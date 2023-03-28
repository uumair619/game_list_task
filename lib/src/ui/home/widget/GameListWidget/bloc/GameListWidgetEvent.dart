
part of 'GameListWidgetBloc.dart';

enum SortType{dateSort , nameSort}
class GameListWidgetEvent extends Equatable
{
  @override
  List<Object?> get props => [];
}
class InitialList extends GameListWidgetEvent{
  @override
  List<Object?> get props => [];
}
class EditItem extends GameListWidgetEvent{

  final GameModel item;
  EditItem(this.item);

  @override
  List<Object?> get props => [];
}

class DeleteItem extends GameListWidgetEvent{

  final GameModel item;
  DeleteItem(this.item);
  @override
  List<Object?> get props => [];
}
class SortList extends GameListWidgetEvent{

  final List<GameModel> items;
  final SortType type;
  SortList(this.items , this.type);
  @override
  List<Object?> get props => [];
}