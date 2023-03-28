import 'package:flutter/material.dart';
import 'package:game_list_task/src/App.dart';
import 'package:game_list_task/src/di/Injector.dart';

void main()  {
  Injector.initGetIt();
  runApp( App());
}

