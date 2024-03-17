// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "forge-std/Script.sol";
import {BalanceController} from "../src/balanceController.sol";
import {Delay} from '@zodiac/contracts/Delay.sol';

contract TopUp is Script {
    
    BalanceController public bc;
    uint256 public targetBalance = 10 * 1e18;
    address public delayModuleAddress = vm.envAddress("SAFE_DELAY_MODULE");
    address public gnosisPayTokenAddress = vm.envAddress("GNOSIS_PAY_TOKEN");
    address public safeAddress = vm.envAddress("SAFE_ADDRESS");
    address public safeOwner = vm.envAddress("SAFE_OWNER");



    function run() public {
        vm.startBroadcast(vm.envUint("DEPLOYER_PRIVATE_KEY"));
        //bc = new BalanceController(targetBalance, delayModuleAddress, gnosisPayTokenAddress, safeAddress);
        bc = BalanceController(0x60FDA2923de9e9ce238Aa9AF27Ef6C7F57c70A2b);
        bc.topUpBalance(10 * 1e18);
    }

}
