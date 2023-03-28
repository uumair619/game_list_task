import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:game_list_task/src/repository/model/GameModel.dart';
import 'package:game_list_task/src/ui/home/widget/GameListWidget/bloc/GameListWidgetBloc.dart';
import 'package:game_list_task/src/utils/AppLocals.dart';
import 'package:share_plus/share_plus.dart';

class AppUtils{

  static showToast(String msg)
  {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
    );
  }

  static  shareDetails(BuildContext context, GameModel item) {
    Share.share('${AppLocals.of(context)!.getText("share_text")} ${item.title??" "}');
    }

  static showAlertDialog(BuildContext context , GameModel item) async{

    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(AppLocals.of(context)!.getText("cancel")),
      onPressed:  () {
        final navigator = Navigator.of(context);
        navigator.pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text(AppLocals.of(context)!.getText("continue")),
      onPressed:  () {
        final navigator = Navigator.of(context);
        navigator.pop();
        context.read<GameListWidgetBloc>().add(DeleteItem(item));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(AppLocals.of(context)!.getText("delete")),
      content: Text(AppLocals.of(context)!.getText("delete_msg")),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    await Future.delayed(Duration.zero);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}