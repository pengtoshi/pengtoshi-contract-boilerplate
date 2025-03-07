// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "./Hello.t.sol";

contract SayHelloTest is HelloTest {
    function setUp() public override {
        super.setUp();
    }

    function test_Hello_SayHelloEventEmitted() public {
        vm.startPrank(users.alice);
        vm.recordLogs();
        hello.sayHello("Alice");
        vm.stopPrank();

        Vm.Log[] memory entries = vm.getRecordedLogs();

        assertEq(entries.length, 1);
        assertEq(entries[0].topics[0], keccak256("SayHello(address,string)"));
        assertEq(entries[0].topics[1], bytes32(uint256(uint160(address(users.alice)))));

        string memory message = abi.decode(entries[0].data, (string));
        assertEq(message, "Hello, Alice! My name is Pengtoshi Nakamoto.");
    }

    function test_HelloUpgradeable_SayHelloEventEmitted() public {
        vm.startPrank(users.alice);
        vm.recordLogs();
        helloUpgradeable.sayHello("Alice");
        vm.stopPrank();

        Vm.Log[] memory entries = vm.getRecordedLogs();

        assertEq(entries.length, 1);
        assertEq(entries[0].topics[0], keccak256("SayHello(address,string)"));
        assertEq(entries[0].topics[1], bytes32(uint256(uint160(address(users.alice)))));

        string memory message = abi.decode(entries[0].data, (string));
        assertEq(message, "Hello, Alice! My name is Pengtoshi Nakamoto.");
    }

    function test_Hello_HelloCountIncreased() public {
        vm.startPrank(users.alice);
        hello.sayHello("Alice");
        vm.stopPrank();

        assertEq(hello.helloCount(), 1);
    }

    function test_HelloUpgradeable_HelloCountIncreased() public {
        vm.startPrank(users.alice);
        helloUpgradeable.sayHello("Alice");
        vm.stopPrank();

        assertEq(helloUpgradeable.helloCount(), 1);
    }
}
