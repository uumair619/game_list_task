import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game_list_task/src/repository/model/GameModel.dart';
import 'package:game_list_task/src/ui/game_form/GameFormPage.dart';
import 'package:game_list_task/src/ui/game_form/widget/GameDetailsFormWidget.dart';
import 'package:game_list_task/src/ui/home/widget/GameListWidget/GameListWidget.dart';
import 'package:game_list_task/src/ui/home/widget/ListFilterWidget/ListFilterWidget.dart';
import 'package:game_list_task/src/utils/AppLocals.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          padding: EdgeInsets.fromLTRB(15, 30, 15, 25),
          child: Column(
            children: [
              Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      AppLocals.of(context)!.getText("title_home"),
                      style: TextStyle(fontSize: 22 , color: Colors.blue , fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    child:  InkWell(
                      onTap: () {

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  GameFormPage(item: GameModel.empty,)),
                        );
                      },
                      child: Icon(Icons.add,color: Colors.blue,
                        size: 25,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 10,),
              ListFilterWidget(),
              SizedBox(height: 10,),
              GameListWidget()


            ],
          ),
        )
    );
  }
}
