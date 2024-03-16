// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;



contract BalanceController {

    uint256 public targetBalance;

    error topupTooHigh();
    error topupTooLow();

    constructor(uint256 _initialTargetBalance) {
        targetBalance = _initialTargetBalance;
    }


    function topUpBalance(uint256 _amount) public {
        if (_amount > targetBalance ) {
            revert topupTooHigh();
        }
        // customs errors TODO
        // topup must be within 10% of target balance after tx

    }


}