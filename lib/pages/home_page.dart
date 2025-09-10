import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ulangan_flutter/components/todocardwidget.dart';
import '../controllers/todo_controller.dart';
import '../routes/routes.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final TodoController todoController = Get.find<TodoController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 48, left: 20, right: 20, bottom: 24),
            decoration: const BoxDecoration(
              color: Color(0xFF3D5AFE),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Today", style: TextStyle(color: Colors.white70)),
                    SizedBox(height: 4),
                    Text(
                      "5 May",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () => Get.toNamed(AppRoutes.addTodo),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text("Add New"),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Obx(() {
              final activeTodos = todoController.todos.where((t) => !t.isDone).toList();

              if (activeTodos.isEmpty) {
                return const Center(child: Text("Belum ada kegiatan"));
              }
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: activeTodos.length,
                itemBuilder: (context, index) {
                  final todo = activeTodos[index];
                  return TodoCardWidget(
                    title: todo.title,
                    project: todo.category,
                    date: todo.date,
                    time: (todo.startTime != null && todo.endTime != null)
                        ? "${todo.startTime} - ${todo.endTime}"
                        : null,
                    isDone: todo.isDone,
                    isActive: todo.id == todoController.activeTaskId.value,
                    onToggleDone: () {
                      todoController.toggleDone(todo.id);
                    },
                    onDelete: () => todoController.deleteTodo(todo.id),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
