// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import {IHello} from "contracts/interface/IHello.sol";

contract Hello is IHello {
    /// @inheritdoc IHello
    address payable public owner;
    /// @inheritdoc IHello
    string public name;
    /// @inheritdoc IHello
    uint256 public helloCount;

    /// @notice Emitted when the hello function is called
    event SayHello(address indexed caller, string message);

    constructor(string memory _name) payable {
        owner = payable(msg.sender);
        name = _name;
        helloCount = 0;
    }

    /// @inheritdoc IHello
    function sayHello(string memory targetName) public {
        helloCount++;
        emit SayHello(msg.sender, string.concat("Hello, ", targetName, "! My name is ", name, "."));
    }
}
