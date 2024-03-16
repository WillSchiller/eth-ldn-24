// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Test, console2} from "forge-std/Test.sol";
import {BalanceController} from "../src/balanceController.sol";

contract BalanceControllerTest is Test {
    
    BalanceController public bc;
    uint256 public targetBalance = 10 * 1e18;
    address public delayModuleAddress = vm.envAddress("SAFE_DELAY_MODULE");
    address public gnosisPayTokenAddress = vm.envAddress("GNOSIS_PAY_TOKEN");
    address public safeAddress = vm.envAddress("SAFE_ADDRESS");

    function setUp() public {
        bc = new BalanceController(targetBalance, delayModuleAddress, gnosisPayTokenAddress, safeAddress);
    }

    function testSetTargetBalance() public {
        bc.setTargetBalance(targetBalance, 2);
        uint256 bufferAmount = (targetBalance * 2) / 100;
        (uint256 target, uint256 buffer, uint256 upper, uint256 lower) = bc.targetBalance();
        assertEq(target, 10 * 1e18);
        assertEq(buffer, 2);
        assertEq(upper, 10 * 1e18 + bufferAmount);
        assertEq(lower, 10 * 1e18 - bufferAmount);
    }


}
