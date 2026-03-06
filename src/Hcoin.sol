// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Hcoin is ERC20{
    address owner;
    mapping(address => bool) public User;

    constructor() ERC20("Hcoin","HC") {
        owner = msg.sender;
    }

    function GiveHc () external {
        require(User[msg.sender] == false ,"Already Received");
        User[msg.sender] = true;
        _mint(msg.sender ,10 ether);
    }

}

