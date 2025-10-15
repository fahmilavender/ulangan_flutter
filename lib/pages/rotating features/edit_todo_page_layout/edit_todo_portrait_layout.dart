import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ulangan_flutter/components/custom_button.dart';
import 'package:ulangan_flutter/components/custom_dropdown.dart';
import 'package:ulangan_flutter/components/custom_textfield.dart';
import 'package:ulangan_flutter/components/customcolors.dart';
import 'package:ulangan_flutter/controllers/add_todo_controller.dart';
import 'package:ulangan_flutter/controllers/todo_controller.dart';
import 'package:ulangan_flutter/models/todo_model.dart';

class EditTodoMobileLayout extends StatefulWidget {
  final Todo todo;
  const EditTodoMobileLayout({super.key, required this.todo});

  @override
  State<EditTodoMobileLayout> createState() => _EditTodoMobileLayoutState();
}

class _EditTodoMobileLayoutState extends State<EditTodoMobileLayout> {
  final TodoController todoController = Get.find<TodoController>();
  final AddTodoController formController = Get.find<AddTodoController>();

  @override
  void initState() {
    super.initState();
    final todo = widget.todo;

    formController.titleController.text = todo.title;
    formController.descriptionController.text = todo.description;
    formController.selectedCategory.value = todo.category;
    formController.selectedDate.value =
        DateFormat("d MMM yyyy").parse(todo.date);

    if (todo.startTime != null) {
      final startParts = todo.startTime!.split(":");
      formController.startTime.value = TimeOfDay(
        hour: int.parse(startParts[0]),
        minute: int.parse(startParts[1].split(" ")[0]),
      );
    }

    if (todo.endTime != null) {
      final endParts = todo.endTime!.split(":");
      formController.endTime.value = TimeOfDay(
        hour: int.parse(endParts[0]),
        minute: int.parse(endParts[1].split(" ")[0]),
      );
    }
  }

  String _formatDate(DateTime date) => DateFormat("d MMM yyyy").format(date);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Customcolors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
          child: Form(
            key: formController.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: const Icon(Icons.close_rounded,
                      color: Customcolors.black, size: 28),
                ),
                const SizedBox(height: 20),
                Text("Edit Task",
                    style: textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Customcolors.textPrimary)),
                const SizedBox(height: 20),

                // DATE
                Text("DATE",
                    style: textTheme.labelSmall
                        ?.copyWith(fontWeight: FontWeight.bold)),
                Obx(() {
                  final date = formController.selectedDate.value;
                  return GestureDetector(
                    onTap: () => formController.pickDate(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      margin: const EdgeInsets.only(bottom: 16, top: 8),
                      decoration: BoxDecoration(
                        color: Customcolors.textFieldFill,
                        borderRadius: BorderRadius.circular(16),
                        border:
                            Border.all(color: Customcolors.textFieldBorder),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(_formatDate(date),
                              style: textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Customcolors.textPrimary)),
                          const Icon(Icons.calendar_today,
                              size: 18, color: Customcolors.iconGrey),
                        ],
                      ),
                    ),
                  );
                }),

                // TIME
                Text("TIME",
                    style: textTheme.labelSmall
                        ?.copyWith(fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    Expanded(
                      child: Obx(() {
                        final start = formController.startTime.value;
                        return GestureDetector(
                          onTap: () =>
                              formController.pickTime(context, true),
                          child: _timeBox(
                              context, start.format(context), textTheme),
                        );
                      }),
                    ),
                    Expanded(
                      child: Obx(() {
                        final end = formController.endTime.value;
                        return GestureDetector(
                          onTap: () =>
                              formController.pickTime(context, false),
                          child:
                              _timeBox(context, end.format(context), textTheme),
                        );
                      }),
                    ),
                  ],
                ),

                // CATEGORY
                const SizedBox(height: 16),
                Text("CATEGORY",
                    style: textTheme.labelSmall
                        ?.copyWith(fontWeight: FontWeight.bold)),
                Obx(() {
                  return CustomDropdown(
                    items: formController.categories
                        .map((cat) => DropdownItem(
                              value: cat,
                              label: cat,
                              color: Customcolors.cardSelected,
                              icon: formController.categoryIcons[cat] ??
                                  Icons.category,
                            ))
                        .toList(),
                    value: formController.selectedCategory.value.isEmpty
                        ? null
                        : formController.selectedCategory.value,
                    onChanged: (value) {
                      if (value != null) formController.selectCategory(value);
                    },
                    hintText: "Select category",
                    fillColor: Customcolors.textFieldFill,
                  );
                }),

                // TITLE
                const SizedBox(height: 16),
                CustomTextField(
                  controller: formController.titleController,
                  label: "Title",
                  focusedBorderColor: Customcolors.bluewidget,
                  validator: formController.validateTitle,
                ),

                // DESCRIPTION
                const SizedBox(height: 16),
                CustomTextField(
                  controller: formController.descriptionController,
                  label: "Description",
                  focusedBorderColor: Customcolors.bluewidget,
                ),

                const SizedBox(height: 24),
                CustomButton(
                  myText: "Update",
                  backgroundColor: Customcolors.bluewidget,
                  myTextColor: Customcolors.white,
                  onPressed: () async {
                    if (formController.formKey.currentState!.validate()) {
                      await todoController.editTodo(
                        widget.todo.id,
                        formController.titleController.text,
                        formController.descriptionController.text,
                        formController.selectedCategory.value,
                        newDate:
                            _formatDate(formController.selectedDate.value),
                        newStartTime:
                            formController.startTime.value.format(context),
                        newEndTime:
                            formController.endTime.value.format(context),
                      );
                      Get.back();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _timeBox(BuildContext context, String text, TextTheme theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      margin: const EdgeInsets.only(top: 8, right: 8),
      decoration: BoxDecoration(
        color: Customcolors.textFieldFill,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Customcolors.textFieldBorder),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text,
              style: theme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Customcolors.textPrimary)),
          const Icon(Icons.access_time,
              size: 18, color: Customcolors.iconGrey),
        ],
      ),
    );
  }
}
