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

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: const Text(
                "Completed Tasks",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Customcolors.textPrimary,
                ),
              ),
            ),

            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
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
                    showDelete: false, 
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
