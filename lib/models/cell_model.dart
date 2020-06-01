import 'package:flutter/material.dart';

import '../enum/enums.dart';

class CellModel {
  int row;
  int column;
  CellStatus cellStatus;
  String cellContent;
  bool hasMine;
  int proximityMines;
  bool minedBeenStepped;
  BoxDecoration boxDecoration;

  CellModel(
      this.row, this.column, this.cellStatus, this.cellContent, this.hasMine,
      [this.proximityMines, this.minedBeenStepped, this.boxDecoration]);
}
