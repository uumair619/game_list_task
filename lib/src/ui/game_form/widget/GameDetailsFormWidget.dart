import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_list_task/src/ui/home/widget/GameListWidget/bloc/GameListWidgetBloc.dart';

import '../../../repository/model/GameModel.dart';
import '../../../utils/AppLocals.dart';
import 'bloc/GameDetailsFormBloc.dart';

class GameDetailsFormWidget extends StatefulWidget {

  GameDetailsFormWidget({
    this.item
  });
  final GameModel? item;

  @override
  State<GameDetailsFormWidget> createState() => _GameDetailsFormWidgetState();
}

class _GameDetailsFormWidgetState extends State<GameDetailsFormWidget> {

  final GlobalKey<FormState> _formKey = GlobalKey();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final locationController = TextEditingController();
  final playerCountController = TextEditingController();
  final dateController = TextEditingController();
  final imageController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<GameDetailsFormBloc , GameDetailsFormState>(
        builder:(context , state){
          if(state.status.isUpdated || state.status.isAdded)
            {
              context.read<GameListWidgetBloc>().add(EditItem(state.gameDetails));
            }
          return
            state.status.isInitial ?
            _getFormView(widget.item , false)
                : state.status.isProcessing ?
            _getFormView(state.gameDetails , true)
                : state.status.isAdded ?
            _getFormView(state.gameDetails , false)
                : state.status.isUpdated ?
            _getFormView(state.gameDetails , false)
                :
            const SizedBox();

        }
    );

  }
  DateTime? selectedDate = null ;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        print("${selectedDate?.toLocal()}".split(' ')[0]);
      });
    }
  }

  Widget _getFormView(GameModel? data , bool isProcessing)
  {

    if(selectedDate == null)
      {
        titleController.text = data?.title ?? " ";
        descriptionController.text = data?.description ?? " ";
        playerCountController.text = data?.playerCount == -1? "" : data?.playerCount.toString() ?? "";
        dateController.text = data?.date ?? " ";
      }
    else
      {
        dateController.text = "${selectedDate?.toLocal()}".split(' ')[0];
      }


    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              key: UniqueKey(),
              decoration: InputDecoration(labelText: AppLocals.of(context)!.getText("title")),
              keyboardType: TextInputType.text,
              controller: titleController,
              validator: (value) {
                if (value!.isEmpty) {
                  return AppLocals.of(context)!.getText("error_required");
                }
              },
            ),
            SizedBox(height: 10,),
            TextFormField(
              decoration: InputDecoration(labelText: AppLocals.of(context)!.getText("desc")),
              keyboardType: TextInputType.text,
              controller: descriptionController,
            ),
            SizedBox(height: 10,),
            TextFormField(
              decoration: InputDecoration(labelText: AppLocals.of(context)!.getText("no_of_player")),
              keyboardType: TextInputType.number,
              controller: playerCountController,
              validator: (value) {
                if (value!.isEmpty) {
                  return AppLocals.of(context)!.getText("error_required");
                }
                if(int.parse(value) < 1)
                  return AppLocals.of(context)!.getText("error_min");
              },
            ),
            SizedBox(height: 10,),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(labelText: 'Date Time'),
                  controller: dateController,
                  onTap: () {
                    _selectDate(context);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return AppLocals.of(context)!.getText("error_required");;
                    }
                  },
                ),
              ],
            ),
            SizedBox(height: 45,),
            Padding(
              padding: const EdgeInsets.only(right: 25, left: 25),
              child: SizedBox(
                key: const Key("add_count"),
                width: double.infinity,
                height: 50,
                child: isProcessing ?
                Center(
                  child: CircularProgressIndicator(),
                ):
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      var id = data?.id ?? 0;
                      GameModel item = GameModel(id, titleController.text, descriptionController.text, int.parse(playerCountController.text), dateController.text);
                      data?.id == -1 ?
                      context.read<GameDetailsFormBloc>().add(AddItem(item))
                      :
                      context.read<GameDetailsFormBloc>().add(UpdateItem(item));

                      selectedDate = null;

                    }
                    },
                  child: Text(
                    data?.id == -1 ?
                    AppLocals.of(context)!.getText("add"):
                    AppLocals.of(context)!.getText("update"),
                    style: TextStyle(fontSize: 18 ),
                  ),
                ),
              ),
            )
          ],

        )
    );


    /*Column(
      children: [
        Spacer(),
        Padding(
          padding: const EdgeInsets.only(right: 25, left: 25),
          child: SizedBox(
            key: const Key("add_count"),
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {

              },
              child: Text(
                AppLocals.of(context)!.getText("add_count"),
                style: TextStyle(fontSize: 18 ),
              ),
            ),
          ),
        )
      ],
    );*/
  }


}