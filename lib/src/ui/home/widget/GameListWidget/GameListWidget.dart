import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_list_task/src/repository/model/GameModel.dart';
import 'package:game_list_task/src/ui/game_form/GameFormPage.dart';
import 'package:game_list_task/src/ui/game_form/widget/bloc/GameDetailsFormBloc.dart';
import 'package:game_list_task/src/ui/home/widget/GameListWidget/bloc/GameListWidgetBloc.dart';
import 'package:game_list_task/src/utils/AppLocals.dart';
import 'package:game_list_task/src/utils/AppUtils.dart';

class GameListWidget extends StatefulWidget {
  GameListWidget({super.key });
  @override
  State<GameListWidget> createState() => _GameListWidgetState();
}

class _GameListWidgetState extends State<GameListWidget> {
  ScrollController _controller = new ScrollController();
  @override
  Widget build(BuildContext context) {

    return BlocBuilder<GameListWidgetBloc , GameListWidgetState>(
        builder:(context , state){
          return
            state.status.isLoading?
            Center(
              child: CircularProgressIndicator(),
            ):
            state.status.isNoItem?
            Center(
              key: Key("no_item"),
              child: Text(AppLocals.of(context)!.getText("error_no_item")),
            ):
            state.status.isUpdated ?
            ListView.builder(
              scrollDirection: Axis.vertical,
              physics: AlwaysScrollableScrollPhysics(),
              controller: _controller,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                String v = state.gameList?[index]?.title ?? "";
                print("$v");
                return Card(
                  elevation: 5,
                  child: ListTile(
                    title:  Text(state.gameList?[index]?.title ?? "" ),
                    subtitle: Text(state.gameList?[index]?.description ?? ""),
                    isThreeLine: true,
                    dense: true,
                    shape: RoundedRectangleBorder(),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(onPressed: () {
                          AppUtils.shareDetails(context, state.gameList?[index] ?? GameModel.empty);
                        }, icon: const Icon(Icons.share)),
                        PopupMenuButton(
                          itemBuilder: (ctx) => [

                            PopupMenuItem(child: Text(AppLocals.of(context)!.getText("edit")),onTap:()async {
                              final navigator = Navigator.of(context);
                              await Future.delayed(Duration.zero);
                              navigator.push(
                                MaterialPageRoute(builder: (_) => GameFormPage(item: state.gameList?[index] ?? GameModel.empty)),
                              );
                              context.read<GameDetailsFormBloc>().add(InitialFormPage());
                            }
                            ),
                            PopupMenuItem(child: Text(AppLocals.of(context)!.getText("delete")),onTap: () {
                              AppUtils.showAlertDialog(context , state.gameList?[index] ?? GameModel.empty);
                            },),
                          ],
                        )
                      ],
                    ),
                  ),
                )
                    ;
              },
              itemCount: state.gameList?.length,
            ) :
            const SizedBox();

        }
    );



  }
}