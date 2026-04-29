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
}
