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

class AddTodoLandscapeLayout extends StatelessWidget {
  final TodoController todoController;
  final AddTodoController formController;

  const AddTodoLandscapeLayout({
    super.key,
    required this.todoController,
    required this.formController,
  });

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
                        "New Task",
                        style: textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Customcolors.textPrimary,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(14),
                        child: const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),

                LayoutBuilder(builder: (context, constraints) {
                  double itemWidth = (constraints.maxWidth - 32) / 2;
                  return Column(
                    children: [
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
                              ),
                            ),
                          ],
                        ),
                      ),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(bottom: 18),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "START TIME",
                                        style: textTheme.labelSmall?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Customcolors.textSecondary,
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: GestureDetector(
                                          onTap: () =>
                                              formController.pickTime(context, true),
                                          child: Obx(() {
                                            final time = formController.startTime.value;
                                            return _buildFieldContainer(
                                              context,
                                              textTheme,
                                              time.format(context),
                                              Icons.access_time,
                                            );
                                          }),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "END TIME",
                                        style: textTheme.labelSmall?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Customcolors.textSecondary,
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: GestureDetector(
                                          onTap: () =>
                                              formController.pickTime(context, false),
                                          child: Obx(() {
                                            final time = formController.endTime.value;
                                            return _buildFieldContainer(
                                              context,
                                              textTheme,
                                              time.format(context),
                                              Icons.access_time,
                                            );
                                          }),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(padding: const EdgeInsets.symmetric(horizontal: 10)),
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: CustomTextField(
                                    controller: formController.titleController,
                                    label: "Title",
                                    focusedBorderColor: Customcolors.bluewidget,
                                    validator: formController.validateTitle,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(top: 32),
                                  child: CustomTextField(
                                    controller: formController.descriptionController,
                                    label: "Description",
                                    focusedBorderColor: Customcolors.bluewidget,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }),

                Container(
                  padding: const EdgeInsets.only(top: 24),
                  width: double.infinity,
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
                          startTime: formController.startTime.value.format(context),
                          endTime: formController.endTime.value.format(context),
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
          Container(
            padding: const EdgeInsets.only(top: 8),
            child: child,
          ),
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
