import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart' show FpdartOnIterable;
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
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<GameProvider>(
            builder: (context, value, child) {
              if (value.isCompleted) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Future.delayed(
                    const Duration(seconds: 1),
                    () {
                      _showCongratulationsDialog(context, value);
                    },
                  );
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
                              context
                                  .read<GameProvider>()
                                  .makeMove(rowIndex, colIndex);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border:
                                    getBoxBorder(Matrix(rowIndex, colIndex)),
                              ),
                              child: getBoxValue(gameBoard, rowIndex, colIndex),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }).toList(),
              );
            },
          )),
    );
  }

  void _showCongratulationsDialog(BuildContext context, GameProvider value) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            children: [
              const Text('Congratulations!'),
              Lottie.asset(
                'assets/animations/celebration.json',
                width: 100,
                height: 100,
                fit: BoxFit.fill,
              ),
            ],
          ),
          content: Text('Congratulations to the winner! ${value.winner}'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                context.read<GameProvider>().restartGame();
                Navigator.of(context).pop();
              },
              child: const Text('Restart'),
            ),
          ],
        );
      },
    );
  }
}
Widget? getBoxValue(List<List<String?>> gameBoard, rowIndex, colIndex) {
  if (gameBoard[rowIndex][colIndex] == 'X') {
    return const Image(image: AssetImage('assets/images/x_image.png'));
  } else if (gameBoard[rowIndex][colIndex] == 'O') {
    return const Image(image: AssetImage('assets/images/o_image.png'));
  }
  return null;
}

BoxBorder getBoxBorder(Matrix matrix) {
  if (matrix.colIndex == 0 && matrix.rowIndex == 0) {
    return const Border(
        right: BorderSide(width: 0.5), bottom: BorderSide(width: 0.5));
  } else if (matrix.colIndex == 1 && matrix.rowIndex == 0) {
    return const Border(
        right: BorderSide(width: 0.5),
        bottom: BorderSide(width: 0.5),
        left: BorderSide(width: 0.5));
  } else if (matrix.colIndex == 2 && matrix.rowIndex == 0) {
    return const Border(
        bottom: BorderSide(width: 0.5), left: BorderSide(width: 0.5));
  } else if (matrix.colIndex == 0 && matrix.rowIndex == 1) {
    return const Border(
        right: BorderSide(width: 0.5),
        top: BorderSide(width: 0.5),
        bottom: BorderSide(width: 0.5));
  } else if (matrix.colIndex == 1 && matrix.rowIndex == 1) {
    return const Border(
        right: BorderSide(width: 0.5),
        top: BorderSide(width: 0.5),
        bottom: BorderSide(width: 0.5),
        left: BorderSide(width: 0.5));
  } else if (matrix.colIndex == 2 && matrix.rowIndex == 1) {
    return const Border(
        bottom: BorderSide(width: 0.5),
        top: BorderSide(width: 0.5),
        left: BorderSide(width: 0.5));
  } else if (matrix.colIndex == 0 && matrix.rowIndex == 2) {
    return const Border(
        right: BorderSide(width: 0.5), top: BorderSide(width: 0.5));
  } else if (matrix.colIndex == 0 && matrix.rowIndex == 2) {
    return const Border(
        right: BorderSide(width: 0.5),
        top: BorderSide(width: 0.5),
        left: BorderSide(width: 0.5));
  } else {
    return const Border(
        left: BorderSide(width: 0.5), top: BorderSide(width: 0.5));
  }
}

class Matrix {
  final int rowIndex;
  final int colIndex;

  Matrix(this.rowIndex, this.colIndex);
}
