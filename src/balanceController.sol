// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Ownable} from '@openzeppelin/contracts/access/Ownable.sol';
import {IERC20} from '@openzeppelin/contracts/token/ERC20/IERC20.sol';
import {Delay} from '@zodiac/contracts/Delay.sol';

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
        }

        // swap yeild barring token to EURe toto
    
       
    }





}