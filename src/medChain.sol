// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Medchain {
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;


    mapping(address => uint256) public balanceOf;  
    mapping(address => mapping(address => uint256)) public allowance;
    //first line keeps track of each address's balance
    //second line tracks how much one account can spend from another's balance

    event Transfer(address indexed from, address indexed to, uint256 amount); 
    event Approval(address indexed owner, address indexed spender, uint256 amount);
    //first line Logs a transfer between accounts 
    //second line Logs when an account gives another permission to spend tokens

    constructor(string memory _name, string memory _symbol, uint8 _decimals, uint256 _initialSupply) {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        totalSupply = _initialSupply;
        balanceOf[msg.sender] = totalSupply;
    }   //Called once on deployment; sets total supply and assigns all tokens to the deployer

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

    function mint(uint256 _amount) public returns (bool) {
        require(_amount > 0, "Amount must be greater than zero");
        totalSupply += _amount;
        balanceOf[msg.sender] += _amount;
        emit Transfer(address(0), msg.sender, _amount);
        return true;
    } //Allows the contract owner to mint new tokens, increasing total supply and the owner's balance
    function burn(uint256 _amount) public returns (bool) {
        require(balanceOf[msg.sender] >= _amount, "Insufficient balance to burn");
        balanceOf[msg.sender] -= _amount;
        totalSupply -= _amount;
        emit Transfer(msg.sender, address(0), _amount);
        return true;
    } //Allows users to burn their tokens, reducing total supply and their own balance
}
