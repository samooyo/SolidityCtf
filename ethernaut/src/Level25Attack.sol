// SPDX-License-Identifier: MIT
pragma solidity <0.7.0;

contract Attack {
    function killMePlease() external {
        selfdestruct(payable(0));
    }
}
