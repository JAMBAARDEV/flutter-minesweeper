import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/game_provider.dart';

class GameStatisticsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var gameProvider = Provider.of<GameProvider>(context);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.yellow),
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      padding: EdgeInsets.all(3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Text(
                'Flagged Mines : ${gameProvider.flaggedCellsWithMine} / ${gameProvider.mineCount}'),
          ),
          OutlineButton(
            onPressed: () {
              gameProvider.initGame();
            },
            color: Colors.green,
            child: Text("Reset"),
            borderSide: BorderSide(color: Colors.yellow),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
          )
        ],
      ),
    );
  }
}
