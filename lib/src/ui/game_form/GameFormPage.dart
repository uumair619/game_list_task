
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_list_task/src/repository/model/GameModel.dart';
import 'package:game_list_task/src/ui/game_form/widget/GameDetailsFormWidget.dart';

import '../../utils/AppLocals.dart';

class GameFormPage extends StatefulWidget {

  const GameFormPage({
    this.item
  });

  final GameModel? item;

  @override
  State<GameFormPage> createState() => _GameFormPageState();
}

class _GameFormPageState extends State<GameFormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          padding: EdgeInsets.fromLTRB(15, 30, 15, 25),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    AppLocals.of(context)!.getText("title_home"),
                    style: TextStyle(fontSize: 22 , color: Colors.blue , fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 30,),
                GameDetailsFormWidget(item: widget.item),
              ],
            ),
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
