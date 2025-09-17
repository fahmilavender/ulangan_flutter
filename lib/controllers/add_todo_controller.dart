import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ulangan_flutter/components/customcolors.dart';

class AddTodoController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

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
    "Sport": Icons.fitness_center,
    "Music": Icons.headphones,
  };

  late final RxString selectedCategory;
  final RxInt selectedDay = 0.obs;

  final Rx<DateTime> selectedDate = DateTime.now().obs;
  final Rx<TimeOfDay> startTime = TimeOfDay(hour: 9, minute: 0).obs;
  final Rx<TimeOfDay> endTime = TimeOfDay(hour: 17, minute: 0).obs;

  @override
  void onInit() {
    super.onInit();
    selectedCategory = categories.first.obs;
  }

  void selectCategory(String cat) => selectedCategory.value = cat;
  void selectDay(int index) => selectedDay.value = index;

  Future<void> pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Customcolors.bluewidget,
            colorScheme: ColorScheme.light(
              primary: Customcolors.bluewidget,
              onPrimary: Customcolors.white,
              surface: Customcolors.white,
              onSurface: Customcolors.textPrimary,
            ),
            dialogBackgroundColor: Customcolors.white,
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      selectedDate.value = picked;
    }
  }

  Future<void> pickTime(BuildContext context, bool isStart) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Customcolors.bluewidget,
            colorScheme: ColorScheme.light(
              primary: Customcolors.bluewidget,
              onPrimary: Customcolors.white,
              surface: Customcolors.white,
              onSurface: Customcolors.textPrimary,
            ),
            dialogBackgroundColor: Customcolors.white,
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      if (isStart) {
        startTime.value = picked;
      } else {
        endTime.value = picked;
      }
    }
  }

  String? validateTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Title cannot be empty";
    }
    return null;
  }

  void resetForm() {
    titleController.clear();
    descriptionController.clear();
    selectedCategory.value = categories.first;
    selectedDay.value = 0;
    selectedDate.value = DateTime.now();
    startTime.value = const TimeOfDay(hour: 9, minute: 0);
    endTime.value = const TimeOfDay(hour: 17, minute: 0);
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}
