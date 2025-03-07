// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

/// @title IHello
/// @notice Interface for the Hello contract
interface IHello {
    /// @notice The owner of the contract
    function owner() external view returns (address payable);

    /// @notice Returns the name which is set in the constructor
    function name() external view returns (string memory);

    /// @notice Returns the number of times the hello function has been called
    function helloCount() external view returns (uint256);

    /// @notice Says hello to the target name
    function sayHello(string memory targetName) external;
}
