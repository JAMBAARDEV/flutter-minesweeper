import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:minesweeper_flutter/enum/enums.dart';
import 'package:minesweeper_flutter/providers/game_provider.dart';

class GameStatusWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var gameProvider = Provider.of<GameProvider>(context);

    return Container(
        padding: EdgeInsets.all(3.0),
        child: Text(_getGameStatusMessage(gameProvider.gameStatus)));
  }

  String _getGameStatusMessage(GameStatus gameStatus) {
    switch (gameStatus) {
      case GameStatus.loose:
        return '💥 💣 💥OUPS ! You stepped on a mine \n  Keep Trying, you'
            'll endup winning';
        break;
      case GameStatus.win:
        return '🎊 🎉Well Done ! You  Win 🎊 🎉';
      default:
        return '😎 Game Ongoing...';
    }
  }
}
