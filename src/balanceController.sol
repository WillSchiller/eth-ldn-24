// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Ownable} from '@openzeppelin/contracts/access/Ownable.sol';

contract BalanceController  is Ownable{

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
        owner = msg.sender;
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

    function topUpBalance(uint256 _amoun) public { //amount
        // amount + balance of this contract must target balance within 3%
        if (_amount > targetBalance ) {
            revert topupTooHigh();
        }
        // customs errors TODO
        // topup must be within 10% of target balance after tx

    }


}