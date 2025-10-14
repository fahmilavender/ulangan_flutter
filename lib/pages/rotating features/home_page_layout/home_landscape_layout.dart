import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ulangan_flutter/components/customcolors.dart';
import 'package:ulangan_flutter/components/todocardwidget.dart';
import 'package:ulangan_flutter/controllers/todo_controller.dart';

class HomeLandscapeLayout extends StatelessWidget {
  final TodoController todoController = Get.find<TodoController>();

  HomeLandscapeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final todayDate = DateFormat('d MMMM', 'id_ID').format(DateTime.now());

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.28,
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: Customcolors.bluecontainer,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(32),
                bottomRight: Radius.circular(32),
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
                Container(padding: const EdgeInsets.only(bottom: 6)),
                Text(
                  todayDate,
                  style: const TextStyle(
                    color: Customcolors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding:
                      EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 4),
                  child: Text(
                    "My Tasks",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Customcolors.black,
                    ),
                  ),
                ),
                Expanded(
                  child: Obx(() {
                    final activeTodos = todoController.todos
                        .where((t) => !t.isDone)
                        .toList();

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

                    return ListView.separated(
                      padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                      itemCount: activeTodos.length,
                      separatorBuilder: (_, __) =>
                          Container(padding: const EdgeInsets.only(bottom: 12)),
                      itemBuilder: (context, index) {
                        final todo = activeTodos[index];
                        return TodoCardWidget(
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
                        );
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
