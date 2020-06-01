import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/game_provider.dart';
import 'game_board_widget.dart';
import 'game_statistics.dart';
import 'game_status_widget.dart';

class GameWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var gameProvider = Provider.of<GameProvider>(context);

    return Scaffold(
        backgroundColor: Colors.black,
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              SizedBox(
                height: 28,
              ),
              ListTile(
                title: Text('Set Board Size'),
                leading: Icon(Icons.apps),
              ),
              DropdownButton(
                value: gameProvider.size,
                items: [7, 12, 16]
                    .map((val) => DropdownMenuItem(
                        value: val, child: Text('Board of $val x $val')))
                    .toList(),
                onChanged: gameProvider.onChangedSize,
              ),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Flutter MineSweeper'),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GameStatisticsWidget(),
              GameStatusWidget(),
              GameBoardWidget(),
            ],
          ),
        ));
  }
}
