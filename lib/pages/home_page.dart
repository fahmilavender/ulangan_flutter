import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ulangan_flutter/components/customFABbutton.dart';
import 'package:ulangan_flutter/routes/routes.dart';
import '../controllers/todo_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final TodoController todoController = Get.find<TodoController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Todo List")),
      body: Obx(() {
        if (todoController.todos.isEmpty) {
          return const Center(child: Text("Belum ada Kegiatan"));
        }

        return ListView.builder(
          itemCount: todoController.todos.length,
          itemBuilder: (context, index) {
            final todo = todoController.todos[index];
            return ListTile(
              leading: Checkbox(
                value: todo.isDone,
                onChanged: (_) => todoController.toggleDone(todo.id),
              ),
              title: Text(
                todo.title,
                style: TextStyle(
                  decoration: todo.isDone
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              subtitle: Text("${todo.category} • ${todo.description}"),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => todoController.deleteTodo(todo.id),
              ),
            );
          },
        );
      }),
      floatingActionButton: CustomFabButton(
        onPressed: () => Get.toNamed(AppRoutes.addTodo),
      ),
    );
  }
}