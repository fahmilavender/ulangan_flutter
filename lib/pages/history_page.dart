import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ulangan_flutter/components/customcolors.dart';
import 'package:ulangan_flutter/components/todocardwidget.dart';
import '../controllers/todo_controller.dart';

class HistoryPage extends StatelessWidget {
  HistoryPage({super.key});

  final TodoController todoController = Get.find<TodoController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Customcolors.bghome,
      appBar: AppBar(
        title: const Text("History Page"),
        backgroundColor: Customcolors.bluecontainer,
        foregroundColor: Customcolors.background,
        centerTitle: true,
      ),
      body: Obx(() {
        final doneTodos = todoController.todos.where((t) => t.isDone).toList();

        if (doneTodos.isEmpty) {
          return const Center(
            child: Text(
              "Belum ada todo yang selesai.",
              style: TextStyle(
                fontSize: 16,
                color: Customcolors.textSecondary,
              ),
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: doneTodos.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final todo = doneTodos[index];
            return TodoCardWidget(
              title: todo.title,
              description: todo.description,
              time: (todo.startTime != null && todo.endTime != null)
                  ? "${todo.startTime} - ${todo.endTime}"
                  : null,
              project: todo.category,
              date: todo.date,
              isDone: todo.isDone,
              isHistory: true,
              showDelete: true,
              showEdit: true,
              onDelete: () => todoController.deleteTodo(todo.id),
              onEdit: () {
                final titleController =
                    TextEditingController(text: todo.title);
                final descController =
                    TextEditingController(text: todo.description);

                Get.defaultDialog(
                  title: "Edit Todo",
                  content: Column(
                    children: [
                      TextField(
                        controller: titleController,
                        decoration: const InputDecoration(labelText: "Title"),
                      ),
                      TextField(
                        controller: descController,
                        decoration: const InputDecoration(labelText: "Description"),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          todoController.editTodo(
                            todo.id,
                            titleController.text,
                            descController.text,
                            todo.category,
                          );
                          Get.back();
                        },
                        child: const Text("Save Changes"),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      }),
    );
  }
}
