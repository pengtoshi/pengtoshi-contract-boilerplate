// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "forge-std/Test.sol";
import {console} from "forge-std/console.sol";
import {Constants} from "./Constants.sol";
import {Users} from "./Users.sol";
import {IHello} from "contracts/interface/IHello.sol";
import {Hello} from "contracts/Hello.sol";
import {HelloUpgradeable} from "contracts/HelloUpgradeable.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

/// @title BaseFixture
/// @notice A base fixture for all test suites
abstract contract BaseFixture is Test, Constants {
    Users internal users;
    IHello internal hello;
    IHello internal helloUpgradeable;

    function setUp() public virtual {
        users = Users({
            owner: createUser("Owner"),
            alice: createUser("Alice"),
            bob: createUser("Bob"),
            charlie: createUser("Charlie")
        });

        vm.startPrank(users.owner);
        deployDependencies();
        vm.stopPrank();
    }

    function deployDependencies() public virtual {
        /* deploy normal contracts */
        hello = IHello(new Hello("Pengtoshi Nakamoto"));

        /* deploy upgradeable contracts */
        address helloUpgradeableImplementation = address(new HelloUpgradeable());
        bytes memory helloUpgradeableInitData = abi.encodeCall(HelloUpgradeable.initialize, ("Pengtoshi Nakamoto"));
        address proxy = address(new ERC1967Proxy(helloUpgradeableImplementation, helloUpgradeableInitData));
        helloUpgradeable = IHello(proxy);
    }

    function createUser(string memory name) internal returns (address payable user) {
        user = payable(makeAddr({name: name}));
        // NOTE: Add common user setup here
    }
}
