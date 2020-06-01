import 'dart:math';
import 'package:flutter/material.dart';

import 'package:minesweeper_flutter/enum/enums.dart';
import 'package:minesweeper_flutter/models/cell_model.dart';

import '../utils.dart';

const NEIGHBOUR_CELLS = [
  [-1, -1],
  [-1, 0],
  [-1, 1],
  [0, -1],
  [0, 1],
  [1, -1],
  [1, 0],
  [1, 1]
];

class GameProvider with ChangeNotifier {
  List<List<CellModel>> _cellsList = [];
  int _size = 7;
  int _mineCount;
  int _remainingCells;
  int _flaggedCellsWithMine;
  GameStatus _gameStatus;

  GameProvider() {
    initGame();
  }

  // Getters
  List<List<CellModel>> get cellsList => _cellsList;
  GameStatus get gameStatus => _gameStatus;
  int get mineCount => _mineCount;
  int get flaggedCellsWithMine => _flaggedCellsWithMine;
  int get size => _size;

  initGame() {
    _mineCount = 0;
    _remainingCells = 0;
    _flaggedCellsWithMine = 0;
    _gameStatus = GameStatus.ongoing;

    _cellsList = List.generate(_size, (y) {
      return List.generate(_size, (x) {
        return CellModel(y, x, CellStatus.open, '', false, 0, false,
            CellBoxDecoration.gradientBox);
      });
    });

    for (int i = 0; i < _size; i++) {
      _assignMine();
    }

    _remainingCells = _size * _size - _mineCount;

    _countMinesAroundCells();
    notifyListeners();
  }

  _assignMine() {
    while (_mineCount < _size * 1.5) {
      int y = Random().nextInt(_size);
      int x = Random().nextInt(_size);
      if (_cellsList[y][x].hasMine != true) {
        _cellsList[y][x].hasMine = true;
        _mineCount++;
      }
    }
  }

  flagCell(CellModel cell) {
    if (_checkWinOrLooseState()) {
      return;
    }
    if (cell.cellStatus == CellStatus.flag) {
      cell.cellStatus = CellStatus.open;
      if (cell.hasMine) _flaggedCellsWithMine--;
      cell.cellContent = '';
    } else {
      cell.cellStatus = CellStatus.flag;
      cell.cellContent = '⛳';
      if (cell.hasMine) _flaggedCellsWithMine++;
      if (_flaggedCellsWithMine == _mineCount) {
        _gameStatus = GameStatus.win;
      }
    }
    notifyListeners();
  }

  checkCell(CellModel cell) {
    if (cell.cellStatus != CellStatus.open ||
        _gameStatus == GameStatus.loose ||
        _gameStatus == GameStatus.win) {
      return;
    } else if (cell.hasMine) {
      cell.minedBeenStepped = true;
      cell.boxDecoration = CellBoxDecoration.orangeBox;
      cell.cellContent = '💣';
      _gameStatus = GameStatus.loose;
      _revealAll();
    } else {
      cell.cellStatus = CellStatus.clear;
      _remainingCells--;

      cell.cellContent = '${cell.proximityMines}';
      cell.boxDecoration = CellBoxDecoration.blackBox;

      if (cell.proximityMines == 0) {
        cell.cellContent = '';
        NEIGHBOUR_CELLS.forEach((neighbour) {
          int checkedRow = cell.row + neighbour[0];
          int checkedCell = cell.column + neighbour[1];

          if ((checkedRow > -1 && checkedRow < _size) &&
              (checkedCell > -1 && checkedCell < _size)) {
            checkCell(_cellsList[cell.row + neighbour[0]]
                [cell.column + neighbour[1]]);
          }
        });
      }

      if (_remainingCells < 1) {
        _gameStatus = GameStatus.win;
      }
    }
    notifyListeners();
  }

  _checkWinOrLooseState() {
    return _gameStatus == GameStatus.loose || _gameStatus == GameStatus.win;
  }

  _revealAll() {
    for (int y = 0; y < _size; y++) {
      for (int x = 0; x < _size; x++) {
        CellStatus status = _cellsList[y][x].cellStatus;
        if (status == CellStatus.open && _cellsList[y][x].hasMine) {
          status = CellStatus.clear;
          _cellsList[y][x].cellContent = '💣';
          if (!_cellsList[y][x].minedBeenStepped)
            _cellsList[y][x].boxDecoration = CellBoxDecoration.blackBox;
        }
      }
    }
    notifyListeners();
  }

  _countMinesAroundCells() {
    for (int y = 0; y < _size; y++) {
      for (int x = 0; x < _size; x++) {
        int proximityMines = 0;
        NEIGHBOUR_CELLS.forEach((neighbour) {
          int valY = y + neighbour[0];
          int valX = x + neighbour[1];
          if ((valY > -1 && valY < _size) &&
              (valX > -1 && valX < _size) &&
              (_cellsList[y + neighbour[0]][x + neighbour[1]].hasMine)) {
            proximityMines++;
          }
        });
        _cellsList[y][x].proximityMines = proximityMines;
      }
    }
  }

  onChangedSize(int size) {
    _size = size;
    initGame();
  }
}
