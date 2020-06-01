import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:minesweeper_flutter/providers/game_provider.dart';
import 'package:minesweeper_flutter/enum/enums.dart';
import '../models/cell_model.dart';

class CellWidget extends StatelessWidget {
  final CellModel cell;
  CellWidget(this.cell);

  @override
  Widget build(BuildContext context) {
    var gameProvider = Provider.of<GameProvider>(context);
    final double widthAndheight =
        MediaQuery.of(context).size.width / gameProvider.size;

    return GestureDetector(
        child: Container(
            alignment: Alignment.center,
            decoration: cell.boxDecoration,
            width: widthAndheight,
            height: widthAndheight,
            child: Text(
              cell.cellContent,
              //_setCellContent(gameProvider.gameStatus),
              style: TextStyle(
                  fontSize: widthAndheight * 0.7, color: Colors.yellow),
            )),
        onTap: () {
          gameProvider.checkCell(cell);
        },
        onLongPress: () {
          gameProvider.flagCell(cell);
        });
  }
}
