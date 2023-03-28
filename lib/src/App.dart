import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:game_list_task/src/ui/game_form/GameFormPage.dart';
import 'package:game_list_task/src/ui/game_form/widget/bloc/GameDetailsFormBloc.dart';
import 'package:game_list_task/src/ui/home/HomePage.dart';
import 'package:game_list_task/src/ui/home/widget/GameListWidget/bloc/GameListWidgetBloc.dart';
import 'package:game_list_task/src/utils/AppLocals.dart';

class App extends StatefulWidget {

  App({super.key });
  @override
  State<App> createState() => _AppState();
  static void setLocale(BuildContext context, Locale newLocale) async {
    _AppState? state = context.findAncestorStateOfType<_AppState>();
    state?.setState(() {
      state._locale = newLocale;
    });

  }
}

class _AppState extends State<App> {

  Locale _locale = Locale('en', '');

  @override
  Widget build(BuildContext context) {
    return
      MultiBlocProvider(
          providers: [
            BlocProvider<GameDetailsFormBloc>(
              create: (context) => GameDetailsFormBloc()..add(InitialFormPage()),
            ),
            BlocProvider<GameListWidgetBloc>(
              create: (context) => GameListWidgetBloc()..add(InitialList()),
            ),
          ],
          child: MaterialApp(
            //title: '',
            locale: _locale,
            localizationsDelegates: [
              AppLocalsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [const Locale('en', ''),const Locale('ar', '')],
            title: "Game List",
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: const HomePage(title: "title"),
          )
      );
  }


}