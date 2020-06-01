import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/game_provider.dart';
import '../components/cell_widget.dart';

class GameBoardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var gameProvider = Provider.of<GameProvider>(context);

    return Table(
      border: TableBorder.all(color: Colors.yellow, width: 1),
      children: [
        ...gameProvider.cellsList.map((row) {
          return TableRow(
              children: [...row.map((cellModel) => CellWidget(cellModel))]);
        })
      ],
    );
  }
}
