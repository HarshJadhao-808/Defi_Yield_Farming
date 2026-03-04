// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "./token.sol";
import "./Yield.sol";

contract Stake {
      Hcoin public token ;
      YToken public yield;
    struct user{
        uint256 lastStaked;
        uint256 staked;
        uint256 rewardsAvailable;
    }

    mapping(address => user) internal Users;

    constructor(address token_address,address yield_address){
        token = Hcoin(token_address);
        yield = YToken(yield_address);
    }

    event staked(address account,uint256 amount,uint256 time);
    event withdrawnStaked(address account,uint256 amount,uint256 time);
    event yieldGiven(address account,uint256 amount,uint256 time);

    function stake(uint256 amount) public {
        require(amount > 0 , "0 Hcoin cannot be staked");
        token.transferFrom(msg.sender,address(this),amount);
        if( Users[msg.sender].staked == 0){
        Users[msg.sender].lastStaked = block.timestamp;
        }else{
            calculate(msg.sender);
        }
        Users[msg.sender].staked += amount;
        emit staked(msg.sender,amount,block.timestamp);
    }

    function withdrawStaked(uint256 amount) public {
        require(Users[msg.sender].staked >= amount,"Not enough staked");
        calculate(msg.sender);
        Users[msg.sender].staked -= amount;
        if(Users[msg.sender].staked == 0){
           Users[msg.sender].lastStaked = 0;
        }
        token.transfer(msg.sender,amount);
        emit withdrawnStaked(msg.sender,amount,block.timestamp);
    }

    function claimReward() public {
        require(Users[msg.sender].staked > 0,"No Reward Available");
        calculate(msg.sender);
        uint256 reward = Users[msg.sender].rewardsAvailable;
        Users[msg.sender].rewardsAvailable = 0;
        yield.giveYield(msg.sender,reward);
        emit yieldGiven(msg.sender,reward,block.timestamp);

    }

    function calculate(address account) internal {
        uint256 intervals = (block.timestamp - Users[account].lastStaked)/1 hours;
        if(intervals < 1){
            return;
        }
        uint256 reward = (Users[account].staked * intervals)/100;
        Users[account].lastStaked += intervals*1 hours;
        Users[account].rewardsAvailable += reward;
    }

     }