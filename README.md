A simple on-chain guessing game built for EVM-compatible networks like Monad. 
Players try to guess a secret number between 1 and 10 by sending a fixed bet. If they guess correctly, they win the entire contract balance.

- Owner sets the secret number and bet amount.
- Players submit guesses with ETH/MOND.
- Correct guess wins the full balance.
- Basic game flow: start → guess → win or try again → end or reset.

This contract is not suitable for production , only for game with friends