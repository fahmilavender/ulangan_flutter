import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ulangan_flutter/components/customcolors.dart';
import 'package:ulangan_flutter/components/todocardwidget.dart';
import '../controllers/todo_controller.dart';
import '../routes/routes.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final TodoController todoController = Get.find<TodoController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Customcolors.bghome,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 48, left: 20, right: 20, bottom: 24),
            decoration: const BoxDecoration(
              color: Customcolors.bluecontainer,
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
                    Text("Today", style: TextStyle(color: Customcolors.textSecondary)),
                    Padding(
                      padding: EdgeInsets.only(top: 4), // ganti SizedBox
                      child: Text(
                        "5 May",
                        style: TextStyle(
                          color: Customcolors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () => Get.toNamed(AppRoutes.addTodo),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Customcolors.background,
                    foregroundColor: Customcolors.blueaksen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text("Add New"),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20),
          ),
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