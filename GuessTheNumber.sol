// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract GuessTheNumber {
    address public owner;
    uint8 private secretNumber;
    uint256 public betAmount;
    bool public isActive;
    event GameStarted(uint8 maxNumber, uint256 betAmount);
    event GuessMade(address indexed player, uint8 guess, bool success);
    event GameEnded();
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner");
        _;
    }

    constructor() {
        owner = msg.sender;
        isActive = false;
    }
    function startGame(uint8 _secretNumber, uint256 _betAmount) external onlyOwner {
        require(_secretNumber > 0 && _secretNumber <= 10, "Number must be between 1 and 10");
        require(!isActive, "Game is already active");

        secretNumber = _secretNumber;
        betAmount = _betAmount;
        isActive = true;

        emit GameStarted(_secretNumber, _betAmount);
    }
    function guess(uint8 _guess) external payable {
        require(isActive, "No active game");
        require(msg.value == betAmount, "Incorrect bet amount");
        require(_guess > 0 && _guess <= 10, "Guess must be 1-10");

        bool success = (_guess == secretNumber);
        if (success) {
            payable(msg.sender).transfer(address(this).balance);
            isActive = false;
        }

        emit GuessMade(msg.sender, _guess, success);
    }
    function endGame() external onlyOwner {
        isActive = false;
        emit GameEnded();
    }
    function withdraw() external onlyOwner {
        payable(owner).transfer(address(this).balance);
    }

    receive() external payable {}
}
