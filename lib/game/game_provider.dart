import 'package:flutter/material.dart';

class GameProvider with ChangeNotifier {
  List<List<String?>> _gameBoard = [
    [null, null, null],
    [null, null, null],
    [null, null, null]
  ];

  String _currentPlayer = 'X';
  bool _isCompleted = false;
  String? _winner;

  final TextEditingController _player1NameController = TextEditingController();
  final TextEditingController _player2NameController = TextEditingController();

  List<List<String?>> get gameBoard => _gameBoard;
  String get currentPlayer => _currentPlayer;
  TextEditingController get player1Controller => _player1NameController;
  TextEditingController get player2Controller => _player2NameController;
  bool get isCompleted => _isCompleted;
  String? get winner => _winner;

  // void setPlayer1Name(String name) {
  //   _player1Name = name;
  //   notifyListeners();
  // }

  // void setPlayer2Name(String name) {
  //   _player2Name = name;
  //   notifyListeners();
  // }

  void switchPlayer() {
    _currentPlayer = _currentPlayer == 'X' ? 'O' : 'X';
    if (_gameBoard.expand((element) => element).contains(null)) {
    final winnerSign = _decideWinner();
    if (winnerSign != null) {
      if (winnerSign == 'X') {
        _winner = (_player1NameController.text == "")
            ? "Player 1"
            : _player1NameController.text;
       
      } else if (winnerSign == 'O') {
        _winner = (_player2NameController.text == "")
            ? "Player 1"
            : _player2NameController.text;
      }
      _isCompleted = true;
    }
  }
    notifyListeners();
  }

  void makeMove(int rowIndex, int colIndex) {
    if (_gameBoard[rowIndex][colIndex] == null) {
      _gameBoard[rowIndex][colIndex] = _currentPlayer;
      switchPlayer();
    }
  }

  String? _decideWinner() {
    if (_fooIsWinnder('X')) {
      return 'X';
    } else if (_fooIsWinnder('O')) {
      return 'O';
    }
    return null;
  }

  bool _fooIsWinnder(String player) {
    if (_gameBoard[0][0] == player &&
        _gameBoard[0][1] == player &&
        _gameBoard[0][2] == player) {
      return true;
    } else if (_gameBoard[1][0] == player &&
        _gameBoard[1][1] == player &&
        _gameBoard[1][2] == player) {
      return true;
    } else if (_gameBoard[2][0] == player &&
        _gameBoard[2][1] == player &&
        _gameBoard[2][2] == player) {
      return true;
    } else if (_gameBoard[0][0] == player &&
        _gameBoard[1][0] == player &&
        _gameBoard[2][0] == player) {
      return true;
    } else if (_gameBoard[0][1] == player &&
        _gameBoard[1][1] == player &&
        _gameBoard[2][1] == player) {
      return true;
    } else if (_gameBoard[0][2] == player &&
        _gameBoard[1][2] == player &&
        _gameBoard[2][2] == player) {
      return true;
    } else if (_gameBoard[0][0] == player &&
        _gameBoard[1][1] == player &&
        _gameBoard[2][2] == player) {
      return true;
    } else if (_gameBoard[0][2] == player &&
        _gameBoard[1][1] == player &&
        _gameBoard[2][0] == player) {
      return true;
    }
    return false;
  }


  restartGame(){
    _gameBoard = [
    [null, null, null],
    [null, null, null],
    [null, null, null]
  ];
  _currentPlayer = 'X';
  _isCompleted = false;
  _winner = null;
  notifyListeners();
  }
}
