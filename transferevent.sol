// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

contract Token {
    uint public totalSupply;
    string public name = "leo";
    string public symbol = "oel";
    uint8 public decimals = 30;
    mapping(address => uint256) balances;
    event Transfer(address, address, uint256);

    constructor() {
        totalSupply = 1000 * (10 ** uint256(decimals));
        balances[msg.sender] = totalSupply;
    }

    function balanceOf(address _address) external view returns (uint) {
        return balances[_address];
    }

    function transfer(address _address, uint _amount) external returns (bool) {
        require(balances[msg.sender] >= _amount, "not enough money");
        balances[msg.sender] -= _amount;
        balances[_address] += _amount;
        emit Transfer(msg.sender, _address, _amount);
        return true;
    }
}
