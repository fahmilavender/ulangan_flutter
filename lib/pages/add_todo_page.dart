import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ulangan_flutter/pages/rotating%20features/add_todo_page_layout/add_todo_landscape_layout.dart';
import 'package:ulangan_flutter/pages/rotating%20features/add_todo_page_layout/add_todo_potrait_layout.dart';
import '../controllers/add_todo_controller.dart';
import '../controllers/todo_controller.dart';

class AddTodoPage extends StatelessWidget {
  AddTodoPage({super.key});

  final TodoController todoController = Get.find<TodoController>();
  final AddTodoController formController = Get.find<AddTodoController>();

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return isLandscape
        ? AddTodoLandscapeLayout(
            todoController: todoController,
            formController: formController,
          )
        : AddTodoPortraitLayout(
            todoController: todoController,
            formController: formController,
          );
  }
}
