class TaskModel {
  String id;
  String title;
  String date;
  String category;
  bool isDone;

  TaskModel({
    required this.id,
    required this.title,
    required this.date,
    required this.category,
    this.isDone = false,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "date": date,
        "category": category,
        "isDone": isDone,
      };

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json["id"],
      title: json["title"],
      date: json["date"],
      category: json["category"],
      isDone: json["isDone"] ?? false,
    );
  }
}
