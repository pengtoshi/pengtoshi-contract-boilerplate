// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "./BaseForkFixture.sol";

contract SendTokenTest is BaseForkFixture {
    function setUp() public override {
        super.setUp();
    }

    function test_SendToken() public {
        vm.startPrank(users.alice);
        wbtc.transfer(users.bob, TOKEN_1);
        vm.stopPrank();

        assertEq(wbtc.balanceOf(users.alice), 0);
        assertEq(wbtc.balanceOf(users.bob), TOKEN_1);
    }
}
