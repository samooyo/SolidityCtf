// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console2} from "forge-std/Script.sol";
import {IEthernaut} from "../interfaces/IEthernaut.sol";
import {Recovery, SimpleToken} from "../src/Level17.sol";

contract Level17 is Script {
    IEthernaut _ethernaut = IEthernaut(vm.envAddress("ETHERNAUT_ADDR"));
    address _caller = vm.addr(vm.envUint("PRIVATE_KEY"));

    function run() public {
        Recovery _instance = Recovery(vm.envAddress("LVL17_ADDR"));
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        // https://ethereum.stackexchange.com/questions/760/how-is-the-address-of-an-ethereum-contract-computed
        address contractAddr = address(
            uint160(
                uint256(
                    keccak256(
                        abi.encodePacked(
                            bytes1(0xd6),
                            bytes1(0x94),
                            address(_instance),
                            bytes1(0x01)
                        )
                    )
                )
            )
        );

        SimpleToken(payable(contractAddr)).destroy(payable(_caller));

        if (contractAddr.balance != 0) {
            console2.log("call failed");
        } else _ethernaut.submitLevelInstance(address(_instance));
    }
}

// forge script script/Level17.s.sol --broadcast --rpc-url sepolia
