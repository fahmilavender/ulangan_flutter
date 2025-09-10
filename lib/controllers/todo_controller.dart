import 'package:get/get.dart';
import '../models/todo_model.dart';

class TodoController extends GetxController {
  final todos = <Todo>[].obs;
  var activeTaskId = Rxn<int>();

  void addTodo(
    String title,
    String category, {
    String date = "Today",
    String? startTime,
    String? endTime,
  }) {
    final id = DateTime.now().millisecondsSinceEpoch;
    todos.add(
      Todo(
        id: id,
        title: title,
        category: category,
        date: date,
        startTime: startTime,
        endTime: endTime,
      ),
    );
  }

  void toggleDone(int id) {
    final index = todos.indexWhere((t) => t.id == id);
    if (index != -1) {
      todos[index] = todos[index].copyWith(isDone: !todos[index].isDone);
      todos.refresh();
    }
  }

  void deleteTodo(int id) {
    todos.removeWhere((t) => t.id == id);
  }

  void editTodo(
    int id,
    String newTitle,
    String newCategory, {
    String? newDate,
    String? newStartTime,
    String? newEndTime,
  }) {
    final index = todos.indexWhere((t) => t.id == id);
    if (index != -1) {
      todos[index] = todos[index].copyWith(
        title: newTitle,
        category: newCategory,
        date: newDate ?? todos[index].date,
        startTime: newStartTime ?? todos[index].startTime,
        endTime: newEndTime ?? todos[index].endTime,
      );
      todos.refresh();
    }
  }

  void setActive(int id) {
    activeTaskId.value = id;
  }
}
