pragma solidity ^0.8.4;

    contract SOAP{
        // Balances for each account
        mapping(address => uint) public balances;
        // Owner of account approves the transfer of an amount to another account
        mapping(address => mapping(address=>uint)) public allowed;
        uint public totalSupply = 10000000000;
        string public name = "Soapbubble";
        string public  symbol = "SOAP";
        uint8 public  decimals = 10;
        uint public RATE = 1;
        event Transfer(address indexed from, address indexed to, uint value);
        event Approval(address indexed owner, address indexed spender, uint value); 
         // Constructor
        constructor(){
            balances[msg.sender] = totalSupply;
        }
        
        // What is the balance of a particular account?
        function balanceOf(address owner) public view returns(uint){
            return balances[owner];
        }
        
         // Transfer the balance from owner's account to another account
        function transfer(address to, uint value) public returns(bool) {
            require(balanceOf(msg.sender) >= value, 'Balance to low');
            balances[to] += value;
            balances[msg.sender] -= value;
            emit Transfer(msg.sender, to, value);
            return true;
        }
        
        function transferFrom(address from, address to, uint value) public returns(bool) {
        require(balanceOf(from) >= value, 'Balance to low');
        require(allowed [from] [msg.sender] >= value, 'Allowed is to low');
        balances[to] += value;
        balances[from] -= value;
        emit Transfer(from, to, value);
        return true;
        }
    
        // Allow _spender to withdraw from your account, multiple times, up to the _value amount.
        // If this function is called again it overwrites the current allowance with _value.
        function approve(address spender, uint value) public returns(bool){
        allowed[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
        }
    }
