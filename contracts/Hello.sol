// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.27;

contract Hello {
    address payable public owner;
    string public name;
    uint256 public helloCount;

    event SayHello(string message);

    constructor() payable {
        owner = payable(msg.sender);
        name = "Pengtoshi Nakamoto";
        helloCount = 0;
    }

    function sayHello(string memory _name) public {
        helloCount++;
        emit SayHello(string.concat("Hello, ", _name, "! My name is ", name, "."));
    }
}
