import 'package:get/get.dart';
import '../models/todo_model.dart';

class TodoController extends GetxController {
  final todos = <Todo>[].obs;

  void addTodo(String title, String description, String category) {
    final id = DateTime.now().millisecondsSinceEpoch;
    todos.add(
      Todo(
        id: id,
        title: title,
        description: description,
        category: category,
      ),
    );
  }

  void toggleDone(int id) {
    final index = todos.indexWhere((t) => t.id == id);
    if (index != -1) {
      todos[index].isDone = !todos[index].isDone;
      todos.refresh();
    }
  }

  void deleteTodo(int id) {
    todos.removeWhere((t) => t.id == id);
  }
}

