import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ulangan_flutter/components/customcolors.dart';
import '../controllers/todo_controller.dart';
import '../controllers/add_todo_controller.dart';
import '../components/custom_textfield.dart';
import '../components/custom_button.dart';

class AddTodoPage extends StatelessWidget {
  AddTodoPage({super.key});

  final TodoController todoController = Get.find<TodoController>();
  final AddTodoController formController = Get.find<AddTodoController>();

  String _formatDate(DateTime date) {
    return DateFormat("d MMM yyyy").format(date);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );

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
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: GestureDetector(
                    onTap: () => Get.back(),
                    child: const Icon(
                      Icons.close_rounded,
                      color: Customcolors.black,
                      size: 28,
                    ),
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 20),
                  child: Text(
                    "New Task",
                    style: textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Customcolors.textPrimary,
                    ),
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Text(
                    "DATE",
                    style: textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Customcolors.textSecondary,
                    ),
                  ),
                ),
                Obx(() {
                  final date = formController.selectedDate.value;
                  return GestureDetector(
                    onTap: () => formController.pickDate(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Customcolors.textFieldFill,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Customcolors.textFieldBorder),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _formatDate(date),
                            style: textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: Customcolors.textPrimary,
                            ),
                          ),
                          const Icon(
                            Icons.calendar_today,
                            size: 18,
                            color: Customcolors.iconGrey,
                          ),
                        ],
                      ),
                    ),
                  );
                }),

                Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Text(
                    "TIME",
                    style: textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Customcolors.textSecondary,
                    ),
                  ),
                ),

                Row(
                  children: [
                    Expanded(
                      child: Obx(() {
                        final time = formController.startTime.value;
                        return GestureDetector(
                          onTap: () => formController.pickTime(context, true),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                            decoration: BoxDecoration(
                              color: Customcolors.textFieldFill,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Customcolors.textFieldBorder,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  time.format(context),
                                  style: textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Customcolors.textPrimary,
                                  ),
                                ),
                                const Icon(
                                  Icons.access_time,
                                  size: 18,
                                  color: Customcolors.iconGrey,
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                    Container(margin: const EdgeInsets.only(left: 12)),
                    Expanded(
                      child: Obx(() {
                        final time = formController.endTime.value;
                        return GestureDetector(
                          onTap: () => formController.pickTime(context, false),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                            decoration: BoxDecoration(
                              color: Customcolors.textFieldFill,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Customcolors.textFieldBorder,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  time.format(context),
                                  style: textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Customcolors.textPrimary,
                                  ),
                                ),
                                const Icon(
                                  Icons.access_time,
                                  size: 18,
                                  color: Customcolors.iconGrey,
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),

                Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 12),
                  child: Text(
                    "CATEGORY",
                    style: textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Customcolors.textSecondary,
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: formController.categories.length,
                  itemBuilder: (context, index) {
                    final cat = formController.categories[index];
                    return Obx(() {
                      final isSelected =
                          formController.selectedCategory.value == cat;
                      return GestureDetector(
                        onTap: () => formController.selectCategory(cat),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Customcolors.cardSelected.withOpacity(0.1)
                                : Customcolors.textFieldFill,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isSelected
                                  ? Customcolors.cardSelected
                                  : Customcolors.cardBorder,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                formController.categoryIcons[cat],
                                color: Customcolors.cardSelected,
                                size: 22,
                              ),
                              Container(margin: const EdgeInsets.only(left: 12)),
                              Expanded(
                                child: Text(
                                  cat,
                                  style: textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Customcolors.textPrimary,
                                  ),
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: Customcolors.iconGrey,
                              ),
                            ],
                          ),
                        ),
                      );
                    });
                  },
                ),

                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: CustomTextField(
                    controller: formController.titleController,
                    label: "Title",
                    focusedBorderColor: Customcolors.bluewidget,
                    validator: formController.validateTitle,
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(top: 14),
                  child: CustomTextField(
                    controller: formController.descriptionController,
                    label: "Description",
                    focusedBorderColor: Customcolors.bluewidget,
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(top: 22),
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
}
