import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../models/todo_model.dart';
import '../Helper/db_helper.dart';

class TodoController extends GetxController {
  final RxList<Todo> todos = <Todo>[].obs;
  final RxnString activeTaskId = RxnString();
  final _uuid = const Uuid();
  final _dbHelper = DBHelper();

  String _generateId() => _uuid.v4();
  int _findIndexById(String id) => todos.indexWhere((t) => t.id == id);

  @override
  void onInit() {
    super.onInit();
    loadTodos();
  }

  Future<void> loadTodos() async {
    final data = await _dbHelper.getTodos();
    todos.assignAll(data);
  }

  Future<void> addTodo(
    String title,
    String description,
    String category, {
    String date = "Today",
    String? startTime,
    String? endTime,
  }) async {
    final todo = Todo(
      id: _generateId(),
      title: title,
      description: description,
      category: category,
      date: date,
      startTime: startTime,
      endTime: endTime,
    );
    await _dbHelper.insertTodo(todo);
    todos.add(todo);
  }

  Future<void> toggleDone(String id) async {
    final index = _findIndexById(id);
    if (index != -1) {
      final updated = todos[index].copyWith(isDone: !todos[index].isDone);
      todos[index] = updated;
      await _dbHelper.updateTodo(updated);
    }
  }

  Future<void> deleteTodo(String id) async {
    await _dbHelper.deleteTodo(id);
    todos.removeWhere((t) => t.id == id);
  }

  Future<void> editTodo(
    String id,
    String newTitle,
    String newDescription,
    String newCategory, {
    String? newDate,
    String? newStartTime,
    String? newEndTime,
  }) async {
    final index = _findIndexById(id);
    if (index != -1) {
      final updated = todos[index].copyWith(
        title: newTitle,
        description: newDescription,
        category: newCategory,
        date: newDate ?? todos[index].date,
        startTime: newStartTime ?? todos[index].startTime,
        endTime: newEndTime ?? todos[index].endTime,
      );
      todos[index] = updated;
      await _dbHelper.updateTodo(updated);
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
