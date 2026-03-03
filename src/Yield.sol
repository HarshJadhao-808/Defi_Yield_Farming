// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract YToken is ERC20{
    address owner;
    address stakeAddress;
    constructor() ERC20("yield","YTC") {
       owner = msg.sender;
    }

    function setStakeAddress(address setAddress) external {
        stakeAddress = setAddress;
    }

    function giveYield(address userAddress , uint256 amount) external {
        require(stakeAddress == msg.sender , "Access Denied");
        _mint(userAddress,amount);
    }
    
}