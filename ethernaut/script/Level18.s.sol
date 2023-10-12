// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console2} from "forge-std/Script.sol";
import {IEthernaut} from "../interfaces/IEthernaut.sol";
import {MagicNum} from "../src/Level18.sol";

contract Level18 is Script {
    IEthernaut _ethernaut = IEthernaut(vm.envAddress("ETHERNAUT_ADDR"));
    address _caller = vm.addr(vm.envUint("PRIVATE_KEY"));

    function run() public {
        MagicNum _instance = MagicNum(vm.envAddress("LVL18_ADDR"));
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        // Runetime Code
        //  602a     Push 0x2a (42) in stack.
        //  6050     Push 0x50 in stack. (slot at which v=0x42 will be stored)
        //  52       Store 0x2a at 0x50 in memory (MSTORE)
        //  6020     Push 0x20, 32 bytes, in stack. (size of return value, uint256)
        //  6050     Push 0x50 (slot at which v=0x42 is stored)
        //  f3      RETURN value 0x42

        // Init Code
        // 600a     Push 0x0a (size of runtime opcode)
        // 600c     Push 0c (the 12 opcodes of init) in stack
        // 6000     Push 0x00 in stack
        // 39       Copy code
        // 600a     Push 0x0a (size of runtime opcode)
        // 6000     Push 0x00 (location of value in memory) in stack.
        // f3      Return value at position p in memory of size s

        bytes memory initCode = hex"600a600c600039600a6000f3";
        bytes memory runTimeCode = hex"602a60505260206050f3";
        bytes memory code = bytes.concat(initCode, runTimeCode);
        address solver;

        assembly {
            solver := create(0, add(code, 0x20), mload(code))
        }

        _instance.setSolver(solver);

        _ethernaut.submitLevelInstance(address(_instance));
    }
}

// forge script script/Level18.s.sol --broadcast --rpc-url sepolia
