import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:minesweeper_flutter/components/game_widget.dart';
import 'providers/game_provider.dart';

void main() => runApp(MineSweeper());

class MineSweeper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => GameProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark(),
          title: "Mine Sweeper",
          home: GameWidget(),
        ));
  }
}
