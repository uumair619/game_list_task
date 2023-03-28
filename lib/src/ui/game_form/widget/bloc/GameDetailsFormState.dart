part of 'GameDetailsFormBloc.dart';

enum GameDetailsFormStatus{ initial, processing ,updated , added , error }

extension GameDetailsFormStatusX on GameDetailsFormStatus {
  bool get isInitial => this == GameDetailsFormStatus.initial;
  bool get isProcessing => this == GameDetailsFormStatus.processing;
  bool get isUpdated => this == GameDetailsFormStatus.updated;
  bool get isAdded => this == GameDetailsFormStatus.added;
  bool get isError => this == GameDetailsFormStatus.error;
}

class GameDetailsFormState extends Equatable
{
  const GameDetailsFormState({
    this.status = GameDetailsFormStatus.initial,
    GameModel? gameDetails,
  }) : gameDetails = gameDetails ?? GameModel.empty;

  final GameModel gameDetails;
  final GameDetailsFormStatus status;

  @override
  List<Object?> get props => [status, gameDetails];

  GameDetailsFormState copyWith({
    GameModel? gameDetails,
    GameDetailsFormStatus? status,
  }) {
    return GameDetailsFormState(
      gameDetails: gameDetails ?? this.gameDetails,
      status: status ?? this.status,
    );
  }


}