// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface AlienCodex {
    function makeContact() external;

    function record(bytes32 _content) external;

    function retract() external;

    function revise(uint i, bytes32 _content) external;
}
