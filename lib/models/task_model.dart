import 'dart:convert';

class TaskModel {
  String title;
  bool isDone;

  TaskModel({required this.title, this.isDone = false});

  Map<String, dynamic> toMap() => {'title': title, 'isDone': isDone};

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(title: map['title'], isDone: map['isDone']);
  }

  static String encode(List<TaskModel> tasks) =>
      json.encode(tasks.map((e) => e.toMap()).toList());

  static List<TaskModel> decode(String tasks) =>
      (json.decode(tasks) as List).map((e) => TaskModel.fromMap(e)).toList();
}
