import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ulangan_flutter/components/todocardwidget.dart';
import '../controllers/todo_controller.dart';

class HistoryPage extends StatelessWidget {
  HistoryPage({super.key});

  final TodoController todoController = Get.find<TodoController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("History")),
      body: Obx(() {
        final doneTodos = todoController.todos.where((t) => t.isDone).toList();

        if (doneTodos.isEmpty) {
          return const Center(
            child: Text("Belum ada todo yang selesai."),
          );
        }


        return ListView.builder(
          itemCount: doneTodos.length,
          itemBuilder: (context, index) {
            final todo = doneTodos[index];
            return Todocardwidget(
              title: todo.title,
              description: todo.description,
              isDone: todo.isDone,
              onTap: () {
              },
            );
          },
        );
      }),
    );
  }
}
