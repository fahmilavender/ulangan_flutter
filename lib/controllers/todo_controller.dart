import 'package:get/get.dart';

class TodoController extends GetxController {
  
  var todos = <Map<String, dynamic>>[].obs;

  void addTodo(String title) {
    todos.add({
      "title": title,
      "isDone": false,
    });
  }

  void toggleDone(int index) {
    todos[index]["isDone"] = !(todos[index]["isDone"] as bool);
    todos.refresh();
  }

  void deleteTodo(int index) {
    todos.removeAt(index);
  }
}
