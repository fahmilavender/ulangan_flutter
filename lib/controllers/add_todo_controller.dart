import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTodoController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();

  final List<String> days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

  final List<String> categories = [
    "Work",
    "Study",
    "Personal",
    "Food",
    "Sport",
    "Music"
  ];

  final Map<String, IconData> categoryIcons = {
    "Work": Icons.work,
    "Study": Icons.school,
    "Personal": Icons.person,
    "Food": Icons.fastfood,
    "Sport": Icons.sports,
    "Music": Icons.headphones,
  };

  // Reactive state
  late final RxString selectedCategory;
  final RxInt selectedDay = 0.obs;

  @override
  void onInit() {
    super.onInit();
    selectedCategory = categories.first.obs;
  }

  // Selectors
  void selectCategory(String cat) => selectedCategory.value = cat;
  void selectDay(int index) => selectedDay.value = index;

  // Validator
  String? validateTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Title cannot be empty";
    }
    return null;
  }

  // Reset form
  void resetForm() {
    titleController.clear();
    selectedCategory.value = categories.first;
    selectedDay.value = 0;
  }

  @override
  void onClose() {
    titleController.dispose();
    super.onClose();
  }
}
