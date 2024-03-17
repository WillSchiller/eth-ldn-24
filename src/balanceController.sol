// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Ownable} from '@openzeppelin/contracts/access/Ownable.sol';
import {IERC20} from '@openzeppelin/contracts/token/ERC20/IERC20.sol';
import {Delay} from '@zodiac/contracts/Delay.sol';
import {Enum} from '@gnosis.pm/safe-contracts/contracts/common/Enum.sol';

interface IAggregationExecutor {
    /// @notice propagates information about original msg.sender and executes arbitrary data
    function execute(address msgSender) external payable;  // 0x4b64e492
}

struct SwapDescription {
    IERC20 srcToken;
    IERC20 dstToken;
    address payable srcReceiver;
    address payable dstReceiver;
    uint256 amount;
    uint256 minReturnAmount;
    uint256 flags;
}

interface I1inch {
     function swap(
        IAggregationExecutor executor,
        SwapDescription calldata desc,
        bytes calldata permit,
        bytes calldata data
    )
        external
        payable
        returns (
            uint256 returnAmount,
            uint256 spentAmount
        );
}

contract BalanceController is Ownable(msg.sender){
    struct TargetBalance {
        uint256 target; // the target wallet balance
        uint256 buffer; // % margin of error used to calculate the upper and lower bounds
        uint256 upperBound;
        uint256 lowerBound;
    }
    TargetBalance public targetBalance;
    address public delayModuleAddress;
    address public SafeSddress;
    IERC20 public gnosisPayToken;

    error targetTopupOutsideOfRange();
    error topUpTooSmall();

    constructor(
        uint256 _initialTargetBalance, 
        address _delayModuleAddress, 
        address _gnosisPayTokenAddress,
        address _safeAddress ) {
        setTargetBalance(_initialTargetBalance, 2);
        delayModuleAddress = _delayModuleAddress;
        gnosisPayToken = IERC20(_gnosisPayTokenAddress);
        SafeSddress = _safeAddress;
    }

    function setTargetBalance(uint256 _targetBalance, uint256 buffer) public onlyOwner {
        uint256 bufferAmount = (_targetBalance * buffer) / 100;
        targetBalance.target = _targetBalance;
        targetBalance.buffer = buffer;
        targetBalance.lowerBound = _targetBalance - bufferAmount;
        targetBalance.upperBound = _targetBalance + bufferAmount;
    }

    function thisEUReBalance() public view returns (uint256) {
        //todo update to EURe balance
        return gnosisPayToken.balanceOf(SafeSddress);
    }

    function topUpBalance(uint256 _amount) public { 
        uint256 currentBalance = thisEUReBalance();
        uint256 newBalance = currentBalance + _amount;
        // Check newBalance will be within the target balance range
        if (newBalance + currentBalance < targetBalance.lowerBound || newBalance > targetBalance.upperBound) {
            revert targetTopupOutsideOfRange();
        }
        // Prevent small topups or sybill attack
        if (_amount <= targetBalance.buffer) {
            revert topUpTooSmall();
            //todo check data of transaction
            //swap yeild barring token to EURe
        }
        bytes memory data = abi.encodeWithSelector(I1inch.swap.selector ); //todo impliment swap
        execTransaction(delayModuleAddress, 0, data, Enum.Operation.Call);
    }

    // https://github.com/gnosisguild/zodiac-modifier-delay/blob/main/contracts/Delay.sol
    // Value and Operation should be zero
    function execTransaction(address to, uint256 value, bytes memory data, Enum.Operation operation) internal {
        Delay delayModule = Delay(delayModuleAddress);
        delayModule.execTransactionFromModule(address(this), value, data, operation);
    }
        
}





