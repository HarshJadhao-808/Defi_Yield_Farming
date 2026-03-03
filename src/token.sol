// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Hcoin is ERC20{
    address owner;
    mapping(address => bool) public Users;

    constructor() ERC20("Hcoin","HC") {
        owner = msg.sender;
    }

    function GiveHc (address userAddress) external {
        require(Users[userAddress] == false );
    }

}