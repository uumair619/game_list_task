part of 'GameDetailsFormBloc.dart';

class GameDetailsFormEvent extends Equatable {
  @override
  List<Object?> get props => [];
}
class InitialFormPage extends GameDetailsFormEvent{
  @override
  List<Object?> get props => [];
}
class UpdateItem extends GameDetailsFormEvent{

  final GameModel item;
  UpdateItem(this.item);

  @override
  List<Object?> get props => [];
}

class AddItem extends GameDetailsFormEvent{

  final GameModel item;
  AddItem(this.item);
  @override
  List<Object?> get props => [];
}