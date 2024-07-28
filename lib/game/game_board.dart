import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:myapp/game/game_provider.dart';
import 'package:provider/provider.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: width,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<GameProvider>(
          builder: (context, value, child) {
            if (value.isCompleted) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _showCongratulationsDialog(context, value);
              });
            }
            final gameBoard = value.gameBoard;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: gameBoard.mapWithIndex((row, rowIndex) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: row.mapWithIndex((cell, colIndex) {
                    return Expanded(
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: InkWell(
                          onTap: () {
                            context.read<GameProvider>().makeMove(rowIndex, colIndex);
                          },
                          child: Container(
                            margin: const EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              border: Border.all(color: Colors.grey.shade400),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: getBoxValue(gameBoard, rowIndex, colIndex),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }

  void _showCongratulationsDialog(BuildContext context, GameProvider value) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Stack(
          children: [
            AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              title: Column(
                children: [
                  const Text('Congratulations!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  Lottie.asset(
                    'assets/animations/celebration.json',
                    width: 100,
                    height: 100,
                    fit: BoxFit.fill,
                  ),
                ],
              ),
              content: Text('Congratulations to the winner! ${value.winner}', style: TextStyle(fontSize: 18)),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    context.read<GameProvider>().restartGame();
                    Navigator.of(context).pop();
                  },
                  child: const Text('Restart', style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Lottie.asset('assets/animations/fireworks.json'),
            ),
          ],
        );
      },
    );
  }

  void _showDrawDialog(BuildContext context, GameProvider value) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Game Drawn!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          content: const Text('Game ended without a winner', style: TextStyle(fontSize: 18)),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                context.read<GameProvider>().restartGame();
                Navigator.of(context).pop();
              },
              child: const Text('Restart', style: TextStyle(fontSize: 18)),
            ),
          ],
        );
      },
    );
  }

  Widget? getBoxValue(List<List<String?>> gameBoard, int rowIndex, int colIndex) {
    if (gameBoard[rowIndex][colIndex] == 'X') {
      return const Image(image: AssetImage('assets/images/x_image.png'));
    } else if (gameBoard[rowIndex][colIndex] == 'O') {
      return const Image(image: AssetImage('assets/images/o_image.png'));
    }
    return null;
  }
}

extension MapWithIndex<E> on List<E> {
  List<T> mapWithIndex<T>(T Function(E e, int index) f) {
    return asMap().map((index, value) => MapEntry(index, f(value, index))).values.toList();
  }
}