import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ulangan_flutter/components/customcolors.dart';
import 'package:ulangan_flutter/components/todocardwidget.dart';
import 'package:ulangan_flutter/controllers/todo_controller.dart';

class HomePortraitLayout extends StatelessWidget {
  final TodoController todoController = Get.find<TodoController>();

  HomePortraitLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final todayDate =
        DateFormat('d MMMM', 'id_ID').format(DateTime.now());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.only(
            top: 48,
            left: 20,
            right: 20,
            bottom: 20,
          ),
          decoration: const BoxDecoration(
            color: Customcolors.bluecontainer,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(28),
              bottomRight: Radius.circular(28),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Today",
                style: TextStyle(
                  color: Customcolors.textSecondary,
                  fontSize: 14,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  todayDate,
                  style: const TextStyle(
                    color: Customcolors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
          child: const Text(
            "My Tasks",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Customcolors.textPrimary,
            ),
          ),
        ),
        Expanded(
          child: Obx(() {
            final activeTodos =
                todoController.todos.where((t) => !t.isDone).toList();
            if (activeTodos.isEmpty) {
              return const Center(
                child: Text(
                  "Belum ada kegiatan",
                  style: TextStyle(
                    color: Customcolors.textSecondary,
                    fontSize: 16,
                  ),
                ),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: activeTodos.length,
              itemBuilder: (context, index) {
                final todo = activeTodos[index];
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
                    isHistory: false,
                    onToggleDone: () {
                      todoController.toggleDone(todo.id);
                    },
                    onDelete: () => todoController.deleteTodo(todo.id),
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
