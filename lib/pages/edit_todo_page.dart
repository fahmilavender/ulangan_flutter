import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ulangan_flutter/controllers/layout_controller.dart';
import 'package:ulangan_flutter/models/todo_model.dart';
import 'rotating features/edit_todo_page_layout/edit_todo_landscape_layout.dart';
import 'rotating features/edit_todo_page_layout/edit_todo_portrait_layout.dart';

class EditTodoPage extends StatelessWidget {
  final Todo todo;
  const EditTodoPage({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    final layoutController = Get.find<LayoutController>();

    return LayoutBuilder(
      builder: (context, constraints) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          layoutController.updateLayout(constraints);
        });

        return Obx(
          () => layoutController.isMobile.value
              ? EditTodoMobileLayout(todo: todo)
              : EditTodoLandscapeLayout(todo: todo),
        );
      },
    );
  }
}
