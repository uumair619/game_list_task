class GameModel
{
  final int? id;
  final String? title;
  final String? description;
  final int? playerCount;
  final String? date;
  static final columns = ["id", "title", "description", "playerCount" , "date"];

  const GameModel(this.id, this.title, this.description, this.playerCount , this.date  );

  factory GameModel.fromMap(Map<dynamic, dynamic> data) {
    return GameModel(
      data['id'],
      data['title'],
      data['description'],
      data['playerCount'],
      data['date'],
    );
  }
  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "description": description,
    "playerCount": playerCount,
    "date": date,
  };

  static const empty = GameModel(-1, '', '',  -1, '');
}