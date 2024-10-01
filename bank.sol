//SPDX-License-Identifier: MIT
pragma solidity ^0.7.6;

contract Bank{
  mapping(address => uint) private balances ;
  address owner;

  constructor() payable{}

  function deposit() external payable{
    balances[msg.sender] += msg.value;
  }


  function withdraw() external payable {
    if(balances[msg.sender] > 0){
    // require(balance[msg.sender] > 0);
    //这里具有重入攻击的风险
      (bool success,) =payable(msg.sender).call{value: balances[msg.sender]}("");
      // 验证取款结果 
      if(success){ 
        balances[msg.sender] = 0; 
      }
    // payable(msg.sender).transfer(balances[msg.sender]);
    // balances[msg.sender] = 0; 
    }

   }
 // //取钱,指定数额
 // function withdraw(uint amount) public payable{
 //     if(balances[msg.sender] >= amount){
 //             // require(balance[msg.sender] > 0);
 //             //这里具有重入攻击的风险
 //             // (bool success,) =payable(msg.sender).call{value: balances[msg.sender]}("");
 //         payable(msg.sender).transfer(amount);
 //         balances[msg.sender] -= amount ; 
 //     }
 // }
 //查询用户的余额
   function getUserBalance() external view returns(uint){
     return balances[msg.sender];
   }
 //获取本合约的余额
   function getContractBalance() external view returns(uint){
     return address(this).balance;
   }

//获取用户地址对应的余额
  function getBalanceByAddress(address Address) external view returns(uint){
    return balances[Address];
  }

//获取当前用户地址
  function getAddress() external view returns (address){
    return msg.sender;
  }

}