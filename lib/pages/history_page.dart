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
      backgroundColor: const Color(0xFFF8F7FF),
      appBar: AppBar(
        title: const Text("History"),
        backgroundColor: const Color(0xFF3D5AFE),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Obx(() {
        final doneTodos = todoController.todos.where((t) => t.isDone).toList();

        if (doneTodos.isEmpty) {
          return const Center(
            child: Text(
              "Belum ada todo yang selesai.",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: doneTodos.length,
          itemBuilder: (context, index) {
            final todo = doneTodos[index];
            return TodoCardWidget(
              title: todo.title,
              time: (todo.startTime != null && todo.endTime != null)
                  ? "${todo.startTime} - ${todo.endTime}"
                  : null,
              project: todo.category,
              date: todo.date,          
              isDone: todo.isDone,
              isActive: false,
              showDelete: false, 
              statusLabel: "Complete",
            );
          },
        );
      }),
    );
  }
}
