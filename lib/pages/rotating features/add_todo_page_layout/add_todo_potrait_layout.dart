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

class AddTodoPortraitLayout extends StatelessWidget {
  final TodoController todoController;
  final AddTodoController formController;

  const AddTodoPortraitLayout({
    super.key,
    required this.todoController,
    required this.formController,
  });

  String _formatDate(DateTime date) {
    return DateFormat("d MMM yyyy").format(date);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));

    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Customcolors.white,
      resizeToAvoidBottomInset: true,
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
                  child: const Icon(
                    Icons.close_rounded,
                    color: Customcolors.black,
                    size: 28,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    "New Task",
                    style: textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Customcolors.textPrimary,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "DATE",
                        style: textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Customcolors.textSecondary,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 8),
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
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "TIME",
                        style: textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Customcolors.textSecondary,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: Obx(() {
                                final time = formController.startTime.value;
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
                            Container(width: 12),
                            Expanded(
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
                    ],
                  ),
                ),

                Container(
                  padding: const EdgeInsets.only(top: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "CATEGORY",
                        style: textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Customcolors.textSecondary,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 8),
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
                                : formController.selectedCategory.value,
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
                    ],
                  ),
                ),

                Container(
                  padding: const EdgeInsets.only(top: 16),
                  child: CustomTextField(
                    controller: formController.titleController,
                    label: "Title",
                    focusedBorderColor: Customcolors.bluewidget,
                    validator: formController.validateTitle,
                  ),
                ),

                Container(
                  padding: const EdgeInsets.only(top: 14),
                  child: CustomTextField(
                    controller: formController.descriptionController,
                    label: "Description",
                    focusedBorderColor: Customcolors.bluewidget,
                  ),
                ),

                Container(
                  padding: const EdgeInsets.only(top: 22),
                  child: CustomButton(
                    myText: "Create",
                    backgroundColor: Customcolors.bluewidget,
                    myTextColor: Customcolors.white,
                    onPressed: () {
                      if (formController.formKey.currentState!.validate()) {
                        todoController.addTodo(
                          formController.titleController.text,
                          formController.descriptionController.text,
                          formController.selectedCategory.value,
                          date: _formatDate(formController.selectedDate.value),
                          startTime:
                              formController.startTime.value.format(context),
                          endTime:
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
              fontWeight: FontWeight.w500,
              color: Customcolors.textPrimary,
            ),
          ),
          Icon(icon, size: 18, color: Customcolors.iconGrey),
        ],
      ),
    );
  }
}
