import 'package:get/get.dart';
import '../models/task_model.dart';

class TaskController extends GetxController {
  var tasks = <TaskModel>[].obs;

  int _idCounter = 0;

  void addTask(String title, String date, String category) {
    tasks.add(
      TaskModel(
        id: (_idCounter++).toString(),
        title: title,
        date: date,
        category: category,
      ),
    );
  }

  void toggleTask(String id) {
    final index = tasks.indexWhere((t) => t.id == id);
    if (index != -1) {
      tasks[index].isDone = !tasks[index].isDone;
      tasks.refresh(); // IMPORTANT
    }
  }

  List<TaskModel> getTasksForDate(String date) {
    return tasks.where((t) => t.date == date).toList();
  }
}
