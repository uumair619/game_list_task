part of 'GameListWidgetBloc.dart';

enum GameListWidgetStatus{ initial, loading ,updated , noItem , error }

extension GameListWidgetStatusX on GameListWidgetStatus {
  bool get isInitial => this == GameListWidgetStatus.initial;
  bool get isLoading => this == GameListWidgetStatus.loading;
  bool get isUpdated => this == GameListWidgetStatus.updated;
  bool get isNoItem => this == GameListWidgetStatus.noItem;
  bool get isError => this == GameListWidgetStatus.error;
}

class GameListWidgetState extends Equatable
{
  const GameListWidgetState({
    this.status = GameListWidgetStatus.initial,
    List<GameModel>? gameList,
  }) : gameList = gameList ;

  final List<GameModel>? gameList;
  final GameListWidgetStatus status;

  @override
  List<Object?> get props => [status, gameList];

  GameListWidgetState copyWith({
    List<GameModel>? gameList,
    GameListWidgetStatus? status,
  }) {
    return GameListWidgetState(
      gameList: gameList ?? this.gameList,
      status: status ?? this.status,
    );
  }


}