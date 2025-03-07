// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.27;

import {IHello} from "contracts/interface/IHello.sol";
import {AccessControlUpgradeable} from "@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol";
import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

contract HelloUpgradeable is IHello, Initializable, AccessControlUpgradeable, UUPSUpgradeable {
    address payable public owner;
    string public name;
    uint256 public helloCount;

    event SayHello(address indexed caller, string message);

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize(string memory _name) public initializer {
        __AccessControl_init();
        __UUPSUpgradeable_init();

        owner = payable(msg.sender);
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);

        name = _name;
        helloCount = 0;
    }

    function sayHello(string memory targetName) public {
        helloCount++;
        emit SayHello(msg.sender, string.concat("Hello, ", targetName, "! My name is ", name, "."));
    }

    // =============================================================
    // Upgrade functions
    // =============================================================

    function _authorizeUpgrade(address newImplementation) internal override onlyRole(DEFAULT_ADMIN_ROLE) {}
}
