import 'package:get/get.dart';
import '../models/todo_model.dart';

class TodoController extends GetxController {
  final RxList<Todo> todos = <Todo>[].obs;
  final RxnInt activeTaskId = RxnInt();

  int _generateId() => DateTime.now().millisecondsSinceEpoch;
  int _findIndexById(int id) => todos.indexWhere((t) => t.id == id);

  void addTodo(String title, String category, {
    String date = "Today",
    String? startTime,
    String? endTime,
  }) {
    todos.add(Todo(
      id: _generateId(),
      title: title,
      category: category,
      date: date,
      startTime: startTime,
      endTime: endTime,
    ));
  }

  void toggleDone(int id) {
    final index = _findIndexById(id);
    if (index != -1) {
      todos[index] = todos[index].copyWith(isDone: !todos[index].isDone);
    }
  }

  void deleteTodo(int id) {
    todos.removeWhere((t) => t.id == id);
  }

  void editTodo(int id, String newTitle, String newCategory, {
    String? newDate,
    String? newStartTime,
    String? newEndTime,
  }) {
    final index = _findIndexById(id);
    if (index != -1) {
      todos[index] = todos[index].copyWith(
        title: newTitle,
        category: newCategory,
        date: newDate ?? todos[index].date,
        startTime: newStartTime ?? todos[index].startTime,
        endTime: newEndTime ?? todos[index].endTime,
      );
    }
  }

  void setActive(int id) {
    activeTaskId.value = id;
  }

  List<Todo> get completedTodos => todos.where((t) => t.isDone).toList();
  List<Todo> get activeTodos => todos.where((t) => !t.isDone).toList();
  Todo? get activeTask => todos.firstWhereOrNull((t) => t.id == activeTaskId.value);
}
