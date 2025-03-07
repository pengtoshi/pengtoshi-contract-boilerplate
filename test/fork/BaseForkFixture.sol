// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "forge-std/StdJson.sol";
import "../common/BaseFixture.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/// @title BaseForkFixture
/// @notice A base fixture for all fork test suites
abstract contract BaseForkFixture is BaseFixture {
    using stdJson for string;
    string public addresses;

    IERC20 public wbtc;

    function setUp() public virtual override {
        vm.createSelectFork({urlOrAlias: "base", blockNumber: 27262879});

        string memory root = vm.projectRoot();
        string memory path = string(abi.encodePacked(root, "/test/fork/addresses.json"));
        addresses = vm.readFile(path);

        BaseFixture.setUp();

        deal(address(wbtc), users.alice, TOKEN_1);
    }

    function deployDependencies() public virtual override {
        wbtc = IERC20(vm.parseJsonAddress(addresses, ".WBTC"));
    }
}
