// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

struct Users {
    /// @dev Admin
    address payable owner;
    /// @dev User, used to initiate calls
    address payable alice;
    /// @dev User, used as recipient
    address payable bob;
    /// @dev User, used as malicious user
    address payable charlie;
}
