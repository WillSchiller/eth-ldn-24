// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Test, console2} from "forge-std/Test.sol";
import {BalanceController} from "../src/balanceController.sol";

contract CounterTest is Test {
    
    BalanceController public bc;
    uint256 public targetBalance = 10 * 1e18;
    address public delayModuleAddress = vm.envAddress("SAFE_DELAY_MODULE");
    address public gnosisPayTokenAddress = vm.envAddress("GNOSIS_PAY_TOKEN");
    address public safeAddress = vm.envAddress("SAFE_ADDRESS");

    function setUp() public {
        bc = new BalanceController(targetBalance, delayModuleAddress, safeAddress);
    }


}
