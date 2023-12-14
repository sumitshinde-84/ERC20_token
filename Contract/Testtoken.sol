// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Testtoken { 
    string public name = "testToken";
    string public symbol = "tst";
    uint8 public decimals = 0;

    uint256 public totalSupply;
    mapping(address => uint256) public balanceOf;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Burn(address indexed from, uint256 value);
    event Mint(address indexed to, uint256 value);

    constructor(uint256 _initialSupply) {
        totalSupply = _initialSupply * (10**uint256(decimals));
        balanceOf[msg.sender] = totalSupply;
    }

    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(_to != address(0), "Invalid address");
        require(balanceOf[msg.sender] >= _value, "Insufficient balance");

        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function burn(uint256 _value) public returns (bool success) {
        require(balanceOf[msg.sender] >= _value, "Insufficient balance");

        balanceOf[msg.sender] -= _value;
        totalSupply -= _value;
        emit Burn(msg.sender, _value);
        return true;
    }

    function mint(address _to, uint256 _value) public returns (bool success) {
        totalSupply += _value;
        balanceOf[_to] += _value;
        emit Mint(_to, _value);
        return true;
    }
}
