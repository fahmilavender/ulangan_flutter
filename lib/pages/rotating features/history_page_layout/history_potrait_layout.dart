import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ulangan_flutter/components/customcolors.dart';
import 'package:ulangan_flutter/components/todocardwidget.dart';
import 'package:ulangan_flutter/controllers/todo_controller.dart';
import 'package:ulangan_flutter/routes/routes.dart';

class HistoryPortraitLayout extends StatelessWidget {
  final TodoController todoController = Get.find<TodoController>();

  HistoryPortraitLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final doneTodos = todoController.todos.where((t) => t.isDone).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding:
              const EdgeInsets.only(top: 48, left: 20, right: 20, bottom: 20),
          decoration: const BoxDecoration(
            color: Customcolors.bluecontainer,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(28),
              bottomRight: Radius.circular(28),
            ),
          ),
          child: const Center(
            child: Text(
              "History",
              style: TextStyle(
                color: Customcolors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

        ),
        Container(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
          child: const Text(
            "Completed Tasks",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Customcolors.textPrimary,
            ),
          ),
        ),
        Expanded(
          child: Obx(() {
            final doneTodos =
                todoController.todos.where((t) => t.isDone).toList();

            if (doneTodos.isEmpty) {
              return const Center(
                child: Text(
                  "Belum ada todo yang selesai.",
                  style: TextStyle(
                    color: Customcolors.textSecondary,
                    fontSize: 16,
                  ),
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: doneTodos.length,
              itemBuilder: (context, index) {
                final todo = doneTodos[index];
                return Container(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: TodoCardWidget(
                    title: todo.title,
                    description: todo.description,
                    project: todo.category,
                    date: todo.date,
                    time: (todo.startTime != null && todo.endTime != null)
                        ? "${todo.startTime} - ${todo.endTime}"
                        : null,
                    isDone: todo.isDone,
                    isHistory: true,
                    showDelete: true,
                    onDelete: () => todoController.deleteTodo(todo.id),
                    onEdit: () => Get.toNamed(
                      AppRoutes.editTodo,
                      arguments: todo,
                    ),
                  ),
                );
              },
            );
          }),
        ),
      ],
    );
  }
}
