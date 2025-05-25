// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Medchain {
    string public name = "Medchain";
    string public symbol = "MED";
    uint8 public decimals = 18;
    uint256 public totalSupply;


    mapping(address => uint256) public balanceOf;  
    //keeps track of each address's balance

    mapping(address => mapping(address => uint256)) public allowance;
     //tracks how much one account can spend from another's balance

    
    event Transfer(address indexed from, address indexed to, uint256 amount); 
    //Logs a transfer between accounts

    event Approval(address indexed owner, address indexed spender, uint256 amount); 
    //Logs when an account gives another permission to spend tokens


    constructor(uint256 _initialSupply) {
        balanceOf[msg.sender] = _initialSupply;
        totalSupply = _initialSupply;
    }
    //Called once on deployment; sets total supply and assigns all tokens to the deployer

    function transfer(address _to, uint256 _amount) public returns (bool) {
        require(balanceOf[msg.sender] >= _amount, "Insufficient balance");

        balanceOf[msg.sender] -= _amount;
        balanceOf[_to] += _amount;

        emit Transfer(msg.sender, _to, _amount);
        return true;
    } //Allows users to send tokens to another address

    function approve(address _spender, uint256 _amount) public returns (bool) {
        allowance[msg.sender][_spender] = _amount;
        emit Approval(msg.sender, _spender, _amount);
        return true;
    } //Allows an account to give another account permission to spend tokens on its behalf

    function transferFrom(address _from, address _to, uint256 _amount) public returns (bool) {
        require(balanceOf[_from] >= _amount, "Insufficient balance");
        require(allowance[_from][msg.sender] >= _amount, "Allowance exceeded");

        allowance[_from][msg.sender] -= _amount;
        balanceOf[_from] -= _amount;
        balanceOf[_to] += _amount;

        emit Transfer(_from, _to, _amount);
        return true;
    } //Allows a spender to transfer tokens from one account to another, using the allowance mechanism
}
