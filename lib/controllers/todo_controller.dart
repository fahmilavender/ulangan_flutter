import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../models/todo_model.dart';

class TodoController extends GetxController {
  final RxList<Todo> todos = <Todo>[].obs;
  final RxnString activeTaskId = RxnString();
  final Uuid _uuid = const Uuid();

  String _generateId() => _uuid.v4(); // ✅ String ID

  int _findIndexById(String id) => todos.indexWhere((t) => t.id == id);

  void addTodo(
    String title,
    String description,
    String category, {
    String date = "Today",
    String? startTime,
    String? endTime,
  }) {
    todos.add(Todo(
      id: _generateId(), // ✅ String ID
      title: title,
      description: description,
      category: category,
      date: date,
      startTime: startTime,
      endTime: endTime,
    ));
  }

  void toggleDone(String id) {
    final index = _findIndexById(id);
    if (index != -1) {
      todos[index] = todos[index].copyWith(isDone: !todos[index].isDone);
    }
  }

  void deleteTodo(String id) {
    todos.removeWhere((t) => t.id == id);
  }

  void editTodo(
    String id,
    String newTitle,
    String newDescription,
    String newCategory, {
    String? newDate,
    String? newStartTime,
    String? newEndTime,
  }) {
    final index = _findIndexById(id);
    if (index != -1) {
      todos[index] = todos[index].copyWith(
        title: newTitle,
        description: newDescription,
        category: newCategory,
        date: newDate ?? todos[index].date,
        startTime: newStartTime ?? todos[index].startTime,
        endTime: newEndTime ?? todos[index].endTime,
      );
    }
  }

  void setActive(String id) {
    activeTaskId.value = id;
  }

  List<Todo> get completedTodos => todos.where((t) => t.isDone).toList();
  List<Todo> get activeTodos => todos.where((t) => !t.isDone).toList();
  Todo? get activeTask =>
      todos.firstWhereOrNull((t) => t.id == activeTaskId.value);
}
