// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.20;



contract balanceController {

    uint256 public targetBalance;

    constructor(uint256 _initialTargetBalance) {
        targetBalance = _initialTargetBalance;
    }


    function topUpBalance(uint256 _amount) public {
        // customs errors TODO
        // topup must be within 10% of target balance after tx

    }


}