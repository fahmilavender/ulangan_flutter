import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ulangan_flutter/components/customcolors.dart';
import 'package:ulangan_flutter/components/todocardwidget.dart';
import 'package:ulangan_flutter/controllers/todo_controller.dart';
import 'package:ulangan_flutter/routes/routes.dart';

class HistoryLandscapeLayout extends StatelessWidget {
  final TodoController todoController = Get.find<TodoController>();

  HistoryLandscapeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Customcolors.bghome,
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
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "History",
                style: TextStyle(
                  color: Customcolors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
                    "Completed Tasks",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Customcolors.black,
                    ),
                  ),
                ),
                Expanded(
                  child: Obx(() {
                    final doneTodos = todoController.todos
                        .where((t) => t.isDone)
                        .toList();

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

                    return ListView.separated(
                      padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                      itemCount: doneTodos.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final todo = doneTodos[index];
                        return TodoCardWidget(
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
