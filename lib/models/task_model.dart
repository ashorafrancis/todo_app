class TaskModel {
  String title;
  String date;
  bool isDone;

  TaskModel({required this.title, required this.date, this.isDone = false});

  Map<String, dynamic> toJson() => {
    "title": title,
    "date": date,
    "isDone": isDone,
  };

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      title: json["title"],
      date: json["date"],
      isDone: json["isDone"] ?? false,
    );
  }
}
