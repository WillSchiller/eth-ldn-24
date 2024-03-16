// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import'@openzeppelin/contracts/access/Ownable.sol';

contract BalanceController is Ownable(msg.sender){
    struct TargetBalance {
        uint256 target; // the target wallet balance
        uint256 buffer; // the amount over or under the target balance that is acceptable
        uint256 lowerBound; 
        uint256 upperBound;
    }
    TargetBalance public targetBalance;
    address public delayModuleAddress;

    error targetTopupOutsideOfRange();
    constructor(uint256 _initialTargetBalance, address _delayModuleAddress) {
        setTargetBalance(_initialTargetBalance, 2);
        delayModuleAddress = _delayModuleAddress;
    }

    function setTargetBalance(uint256 _targetBalance, uint256 buffer) public onlyOwner {
        uint256 bufferAmount = (_targetBalance * buffer) / 100;
        targetBalance.target = _targetBalance;
        targetBalance.buffer = buffer;
        targetBalance.lowerBound = _targetBalance - bufferAmount;
        targetBalance.upperBound = _targetBalance + bufferAmount;
    }

    function topUpBalance(uint256 _amount) public { //amount
        // amount + balance of this contract must be target balance within 2%
        // if not, revert
        // send swap tx to delay module
        uint256 amount = _amount;
    }


}