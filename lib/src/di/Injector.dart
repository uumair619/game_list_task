
import 'package:game_list_task/src/database/DatabaseHelper.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';

class Injector
{
  static final serviceLocator = GetIt.instance;
  static void initGetIt() async
  {

    serviceLocator.registerSingletonAsync(() =>DatabaseHelper.initDB());

  }
}