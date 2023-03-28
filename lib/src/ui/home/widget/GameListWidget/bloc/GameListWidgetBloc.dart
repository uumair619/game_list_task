import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_list_task/src/database/DatabaseHelper.dart';
import 'package:game_list_task/src/di/Injector.dart';
import 'package:game_list_task/src/repository/model/GameModel.dart';

part 'GameListWidgetEvent.dart';
part 'GameListWidgetState.dart';

class GameListWidgetBloc extends Bloc<GameListWidgetEvent , GameListWidgetState> {

  GameListWidgetBloc() :super(const GameListWidgetState()) {
    on<InitialList>(_mapInitialListEventToState);
    on<EditItem>(_mapEditItemEventToState);
    on<DeleteItem>(_mapDeleteItemEventToState);
    on<SortList>(_mapSortListEventToState);
  }

  void _mapInitialListEventToState(InitialList event , Emitter<GameListWidgetState> emit) async {
    try {
      emit(state.copyWith(status: GameListWidgetStatus.loading ,  gameList: null,));
      await Injector.serviceLocator.allReady();
      var database = Injector.serviceLocator<DatabaseHelper>();
      var items = await database.getAllGames();
      items.length == 0 ?
      emit(state.copyWith(status: GameListWidgetStatus.noItem ,  gameList: items,))
      :
      emit(state.copyWith(status: GameListWidgetStatus.updated ,  gameList: items,))
      ;
    } catch (error) {
      print("$error");
      /*emit(state.copyWith(status: WeatherWidgetStatus.error));*/
    }
  }

  void _mapEditItemEventToState(EditItem event , Emitter<GameListWidgetState> emit) async {
    try {
      var database = Injector.serviceLocator<DatabaseHelper>();
      var items = await database.getAllGames();
      emit(state.copyWith(status: GameListWidgetStatus.updated ,  gameList: items,));
    } catch (error) {
      /*emit(state.copyWith(status: WeatherWidgetStatus.error));*/
    }
  }


  void _mapDeleteItemEventToState(DeleteItem event , Emitter<GameListWidgetState> emit) async {
    try {
      var database = Injector.serviceLocator<DatabaseHelper>();
      database.deleteGame(event.item.id ?? -1);
      var items = await database.getAllGames();
      items.length == 0 ?
      emit(state.copyWith(status: GameListWidgetStatus.noItem ,  gameList: items,))
          :
      emit(state.copyWith(status: GameListWidgetStatus.updated ,  gameList: items,))
      ;
    } catch (error) {
      /*emit(state.copyWith(status: WeatherWidgetStatus.error));*/
    }
  }

  void _mapSortListEventToState(SortList event , Emitter<GameListWidgetState> emit) async {
    try {
      emit(state.copyWith(status: GameListWidgetStatus.loading ,  gameList: null,));
      var database = Injector.serviceLocator<DatabaseHelper>();
      var items =  event.type == SortType.dateSort ? await database.getTimeSortedGameList() : await database.getNameSortedGameList();
      items.length == 0 ?
      emit(state.copyWith(status: GameListWidgetStatus.noItem ,  gameList: items,))
          :
      emit(state.copyWith(status: GameListWidgetStatus.updated ,  gameList: items,))
      ;
    } catch (error) {
      /*emit(state.copyWith(status: WeatherWidgetStatus.error));*/
    }
  }

}