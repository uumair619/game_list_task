
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_list_task/src/database/DatabaseHelper.dart';
import 'package:game_list_task/src/di/Injector.dart';
import 'package:game_list_task/src/repository/model/GameModel.dart';
import 'package:game_list_task/src/utils/AppUtils.dart';
import 'package:sqflite/sqflite.dart';

part 'GameDetailsFormEvent.dart';
part 'GameDetailsFormState.dart';

class GameDetailsFormBloc extends Bloc<GameDetailsFormEvent , GameDetailsFormState>
{

  GameDetailsFormBloc():super( GameDetailsFormState()){

    on<InitialFormPage>(_mapInitialFormPageEventToState);
    on<UpdateItem>(_mapUpdateItemEventToState);
    on<AddItem>(_mapAddItemEventToState);

  }

  void _mapInitialFormPageEventToState(InitialFormPage event, Emitter<GameDetailsFormState> emit) async {
    try {
      emit(state.copyWith(status: GameDetailsFormStatus.initial ,  gameDetails: GameModel.empty,));
    } catch (error) {
      /*emit(state.copyWith(status: WeatherWidgetStatus.error));*/
    }
  }

  void _mapUpdateItemEventToState(UpdateItem event, Emitter<GameDetailsFormState> emit) async {
    try {
      emit(state.copyWith(status: GameDetailsFormStatus.processing ,  gameDetails: event.item,));
      var database = Injector.serviceLocator<DatabaseHelper>();
      database.updateGame(event.item);
      emit(state.copyWith(status: GameDetailsFormStatus.updated ,  gameDetails: GameModel.empty,));
      AppUtils.showToast("Data Updated");

    } catch (error) {
      print("$error");
      emit(state.copyWith(status: GameDetailsFormStatus.error ,  gameDetails: null,));
    }
  }

  void _mapAddItemEventToState(AddItem event, Emitter<GameDetailsFormState> emit) async {
    try {

      emit(state.copyWith(status: GameDetailsFormStatus.processing ,  gameDetails: event.item,));
      var database = Injector.serviceLocator<DatabaseHelper>();
      database.insertGame(event.item);
      emit(state.copyWith(status: GameDetailsFormStatus.added ,  gameDetails:  GameModel.empty,));
      AppUtils.showToast("Item Added");
    } catch (error) {
      print("add $error");
      emit(state.copyWith(status: GameDetailsFormStatus.error ,  gameDetails: null,));
    }
  }
}