// import 'package:get/get.dart';

// class TodoController extends GetxController {
  
//   var todos = <Map<String, dynamic>>[].obs;

//   void addTodo(String title) {
//     todos.add({
//       "title": title,
//       "isDone": false,
//     });
//   }

//   void toggleDone(int index) {
//     todos[index]["isDone"] = !(todos[index]["isDone"] as bool);
//     todos.refresh();
//   }

//   void deleteTodo(int index) {
//     todos.removeAt(index);
//   }
// }
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

