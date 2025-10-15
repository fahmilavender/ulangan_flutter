import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ulangan_flutter/components/custom_button.dart';
import 'package:ulangan_flutter/components/custom_dropdown.dart';
import 'package:ulangan_flutter/components/custom_textfield.dart';
import 'package:ulangan_flutter/components/customcolors.dart';
import 'package:ulangan_flutter/controllers/add_todo_controller.dart';
import 'package:ulangan_flutter/controllers/todo_controller.dart';
import 'package:ulangan_flutter/models/todo_model.dart';

class EditTodoWidescreenLayout extends StatelessWidget {
  final Todo todo;
  final TodoController todoController = Get.find<TodoController>();
  final AddTodoController formController = Get.find<AddTodoController>();

  EditTodoWidescreenLayout({super.key, required this.todo}) {
    // Inisialisasi form dengan data todo lama
    formController.titleController.text = todo.title;
    formController.descriptionController.text = todo.description;
    formController.selectedCategory.value = todo.category;
    formController.selectedDate.value =
        DateFormat("d MMM yyyy").parse(todo.date);

    if (todo.startTime != null) {
      final parts = todo.startTime!.split(":");
      formController.startTime.value = TimeOfDay(
        hour: int.parse(parts[0]),
        minute: int.parse(parts[1].split(" ")[0]),
      );
    }
    if (todo.endTime != null) {
      final parts = todo.endTime!.split(":");
      formController.endTime.value = TimeOfDay(
        hour: int.parse(parts[0]),
        minute: int.parse(parts[1].split(" ")[0]),
      );
    }
  }

  String _formatDate(DateTime date) => DateFormat("d MMM yyyy").format(date);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));

    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Customcolors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
          child: Form(
            key: formController.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // HEADER
                Container(
                  padding: const EdgeInsets.only(bottom: 28),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: const Icon(
                          Icons.close_rounded,
                          color: Customcolors.black,
                          size: 28,
                        ),
                      ),
                      Text(
                        "Edit Task",
                        style: textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Customcolors.textPrimary,
                        ),
                      ),
                      const SizedBox(width: 56),
                    ],
                  ),
                ),

                // FORM
                LayoutBuilder(builder: (context, constraints) {
                  double itemWidth = (constraints.maxWidth - 32) / 2;

                  return Column(
                    children: [
                      // Date + Category
                      Container(
                        padding: const EdgeInsets.only(bottom: 20, left: 2),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSection(
                              textTheme,
                              label: "Date",
                              width: itemWidth,
                              child: Obx(() {
                                final date = formController.selectedDate.value;
                                return GestureDetector(
                                  onTap: () => formController.pickDate(context),
                                  child: _buildFieldContainer(
                                    context,
                                    textTheme,
                                    _formatDate(date),
                                    Icons.calendar_today,
                                  ),
                                );
                              }),
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 26.5),
                              child: _buildSection(
                                textTheme,
                                label: "Category",
                                width: itemWidth,
                                child: Obx(() {
                                  return CustomDropdown(
                                    items: formController.categories.map((cat) {
                                      return DropdownItem(
                                        value: cat,
                                        label: cat,
                                        color: Customcolors.cardSelected,
                                        icon: formController.categoryIcons[cat] ??
                                            Icons.category,
                                      );
                                    }).toList(),
                                    value: formController
                                            .selectedCategory.value.isEmpty
                                        ? null
                                        : formController
                                            .selectedCategory.value,
                                    onChanged: (value) {
                                      if (value != null) {
                                        formController.selectCategory(value);
                                      }
                                    },
                                    hintText: "Select category",
                                    fillColor: Customcolors.textFieldFill,
                                  );
                                }),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Time + Title + Description
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // LEFT
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildSection(
                                  textTheme,
                                  label: "Start Time",
                                  width: double.infinity,
                                  child: Obx(() {
                                    final time =
                                        formController.startTime.value;
                                    return GestureDetector(
                                      onTap: () =>
                                          formController.pickTime(context, true),
                                      child: _buildFieldContainer(
                                        context,
                                        textTheme,
                                        time.format(context),
                                        Icons.access_time,
                                      ),
                                    );
                                  }),
                                ),
                                const SizedBox(height: 20),
                                _buildSection(
                                  textTheme,
                                  label: "End Time",
                                  width: double.infinity,
                                  child: Obx(() {
                                    final time = formController.endTime.value;
                                    return GestureDetector(
                                      onTap: () =>
                                          formController.pickTime(context, false),
                                      child: _buildFieldContainer(
                                        context,
                                        textTheme,
                                        time.format(context),
                                        Icons.access_time,
                                      ),
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(width: 20),

                          // RIGHT
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextField(
                                  controller: formController.titleController,
                                  label: "Title",
                                  focusedBorderColor: Customcolors.bluewidget,
                                  validator: formController.validateTitle,
                                ),
                                const SizedBox(height: 32),
                                CustomTextField(
                                  controller:
                                      formController.descriptionController,
                                  label: "Description",
                                  focusedBorderColor: Customcolors.bluewidget,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }),

                // BUTTON
                Container(
                  padding: const EdgeInsets.only(top: 24),
                  width: double.infinity,
                  child: CustomButton(
                    myText: "Update",
                    backgroundColor: Customcolors.bluewidget,
                    myTextColor: Customcolors.white,
                    onPressed: () async {
                      if (formController.formKey.currentState!.validate()) {
                        await todoController.editTodo(
                          todo.id,
                          formController.titleController.text,
                          formController.descriptionController.text,
                          formController.selectedCategory.value,
                          newDate: _formatDate(formController.selectedDate.value),
                          newStartTime:
                              formController.startTime.value.format(context),
                          newEndTime:
                              formController.endTime.value.format(context),
                        );
                        Get.back();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ========== HELPERS ==========
  Widget _buildSection(TextTheme textTheme,
      {required String label,
      required Widget child,
      required double width}) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Customcolors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }

  Widget _buildFieldContainer(
      BuildContext context, TextTheme textTheme, String text, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Customcolors.textFieldFill,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Customcolors.textFieldBorder),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: textTheme.bodyMedium?.copyWith(
              color: Customcolors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
          Icon(icon, size: 18, color: Customcolors.iconGrey),
        ],
      ),
    );
  }
}
