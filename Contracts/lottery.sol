pragma solidity ^0.4.17;

contract Lottery {
    address public manager;
    address[] public players;
    
    function Lottery() public {
        manager = msg.sender;
    }
    
    function Entry() public payable {
        require(msg.value > .01 ether);
        players.push(msg.sender);
    }
    function random() public view returns(uint) {
        uint(keccak256(block.difficulty, now, players));
    }
    function pickWinner() public onlyManagercall {
        uint index = random() % players.length;
        players[index].transfer(this.balance);
        players = new address[](0);
    }
    modifier onlyManagercall() {
       require(msg.sender == manager); 
       _;
    }
    function getPlayers() public view returns(address[]) {
        return players;
    }
}

