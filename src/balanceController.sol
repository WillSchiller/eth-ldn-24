// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

//todo import zeppelin ownbale

contract BalanceController {

    struct TargetBalance {
        uint256 target;
        uint256 lowerBound;
        uint256 upperBound;
    }

    TargetBalance public targetBalance;

    error targetTopupOutsideOfRange()


    constructor(uint256 _initialTargetBalance) {
        targetBalance = _initialTargetBalance;
    }

    // todo add function for setting target balance 


    function topUpBalance(uint256 _amoun) public { //amount
        // amount + balance of this contract must target balance within 3%
        if (_amount > targetBalance ) {
            revert topupTooHigh();
        }
        // customs errors TODO
        // topup must be within 10% of target balance after tx

    }


}