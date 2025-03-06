// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.27;

contract Hello {
    address payable public owner;
    string public name;
    uint256 public helloCount;

    event SayHello(string message);

    constructor(string memory _name) payable {
        owner = payable(msg.sender);
        name = _name;
        helloCount = 0;
    }

    function sayHello(string memory targetName) public {
        helloCount++;
        emit SayHello(string.concat("Hello, ", targetName, "! My name is ", name, "."));
    }
}
