// SPDX-License-Identifier: MIT
pragma solidity 0.8.21;

interface ILevel00 {
    function authenticate(string memory passkey) external;

    function getCleared() external view returns (bool);

    function info() external pure returns (string memory);

    function info1() external pure returns (string memory);

    function info2(string memory param) external pure returns (string memory);

    function info42() external pure returns (string memory);

    function infoNum() external view returns (uint8);

    function method7123949() external pure returns (string memory);

    function password() external view returns (string memory);

    function theMethodName() external view returns (string memory);
}
