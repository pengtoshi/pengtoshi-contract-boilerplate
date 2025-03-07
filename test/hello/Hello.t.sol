// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "../common/BaseFixture.sol";

contract HelloTest is BaseFixture {
    function setUp() public virtual override {
        super.setUp();
    }

    function test_InitialState() public {
        assertEq(hello.owner(), users.owner);
        assertEq(hello.name(), "Pengtoshi Nakamoto");
        assertEq(hello.helloCount(), 0);
        assertEq(helloUpgradeable.owner(), users.owner);
        assertEq(helloUpgradeable.name(), "Pengtoshi Nakamoto");
        assertEq(helloUpgradeable.helloCount(), 0);
    }
}
