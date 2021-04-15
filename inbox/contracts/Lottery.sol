pragma solidity ^0.4.17;

contract Lottery {
    address public manager;
    address[] public contestants;
    
    function Lottery() public {
        manager = msg.sender;
    }
    
    function enter() public payable {
        require(msg.value > 0.1 ether);
        contestants.push(msg.sender);
    }
    
    function random() private view returns (uint) {
       return uint(keccak256(block.difficulty, now, contestants));
    } 
    
    function pickWinner() public restricted {
        uint index = random() % contestants.length;
        contestants[index].transfer(this.balance); 
        contestants = new address[](0); 
    }
    
    modifier restricted() {
        require(msg.sender == manager);
        _;
    }
    
    function listPlayers() public view returns (address[]) {
        return contestants;
    }
}