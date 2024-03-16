// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Test, console2} from "forge-std/Test.sol";
import {BalanceController} from "../src/balanceController.sol";

contract CounterTest is Test {
    
    BalanceController public bc;
    uint256 public targetBalance = 10 * 1e18;

    function setUp() public {
        bc = new BalanceController(targetBalance);
    }


}
