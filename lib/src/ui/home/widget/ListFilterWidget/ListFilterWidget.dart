

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_list_task/src/App.dart';
import 'package:game_list_task/src/ui/home/widget/GameListWidget/bloc/GameListWidgetBloc.dart';
import 'package:game_list_task/src/utils/AppLocals.dart';

class ListFilterWidget extends StatefulWidget {
  ListFilterWidget({super.key });
  @override
  State<ListFilterWidget> createState() => _ListFilterWidgetState();
}

class _ListFilterWidgetState extends State<ListFilterWidget> {

  bool _isShow = false;
  List sortItems = [
    {
      "id": 0,
      "value": false,
      "title": "Date",
    },
    {
      "id": 1,
      "value": false,
      "title": "Title",
    }
  ];

  List langItems = [
    {
      "id": 0,
      "value": false,
      "title": "En",
    },
    {
      "id": 1,
      "value": false,
      "title": "Ar",
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            child: InkWell(
              child: Text(AppLocals.of(context)!.getText("filters") ,style: TextStyle(fontSize: 14, color: Colors.blue , fontWeight: FontWeight.bold)),
              onTap: () {
                setState(() {
                  _isShow = !_isShow;
                });
              },
            ),
          ),
          SizedBox(height: 10,),
          Visibility(
            visible: _isShow,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppLocals.of(context)!.getText("sort")),
                  _getCheckBoxes(sortItems , true),
                  Text(AppLocals.of(context)!.getText("language")),
                  _getCheckBoxes(langItems , false)

                ],

              )
          ),

        ],
      ),
    );



  }

  Widget _getCheckBoxes(List item , bool isSort)
  {
    return Row(
      children: List.generate(item.length, (index) => Expanded(
        child: CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          contentPadding: EdgeInsets.zero,
          dense: true,
          title: Text(
            item[index]["title"],
            style: const TextStyle(
              fontSize: 14.0,
              color: Colors.black,
            ),
          ),
          value: item[index]["value"],
          onChanged: (value) {
            setState(() {
              for (var element in item) {
                element["value"] = false;
              }
              item[index]["value"] = value;
              if(isSort)
                {
                  index == 0 ?
                  context.read<GameListWidgetBloc>().add(SortList(List.empty(),SortType.dateSort))
                  :
                  context.read<GameListWidgetBloc>().add(SortList(List.empty(),SortType.nameSort));
                }
              else
                {
                  setState(() {
                    index == 0 ?
                    App.setLocale(context, const Locale("en", "")):
                    App.setLocale(context, const Locale("ar", ""));
                  });
                }


            });
          },
        ),
      )
      ),
    );
  }
}