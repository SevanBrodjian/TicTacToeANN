# Tic Tac Toe Neural Network

## Introduction

This project was a personal exploration into Artificial Neural Networks and aimed to create a neural network capable of learning to play the game of Tic Tac Toe from scratch. While the project did not reach its initial goal, it served as a valuable learning experience that exposed the complexity behind neural networks and the importance of utilizing existing code and packages.

## Project Overview

The project includes a user interface that allows users to play Tic Tac Toe against the neural network. The neural network consists of:

- Two input neurons for each field on the board (total of 18 input neurons)
- One hidden layer with 12 neurons
- Nine output neurons with a softmax function to choose the field for the computer's move

Each neuron uses a sigmoid activation function, and a bias neuron is added to the input and hidden layers. The network is a traditional feed-forward neural network, implemented without any packages or built-in functions. Instead, all derivations and calculations were manually coded.

## Challenges and Lessons Learned

Despite weeks of effort, the algorithm struggled to learn the game effectively. A minmax algorithm was implemented to train the model, but it resulted in only marginal performance improvements.

This project provided a deeper understanding of the challenges in designing and training neural networks and highlighted the value of using existing packages and resources. While the project did not achieve its initial objective, it laid the foundation for future explorations into the world of artificial intelligence and machine learning.

## Future Work

There are plans to revisit and improve this project in the future.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details
