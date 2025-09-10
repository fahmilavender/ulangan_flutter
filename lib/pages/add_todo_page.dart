import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/todo_controller.dart';
import '../components/custom_textfield.dart';
import '../components/custom_button.dart';

class AddTodoPage extends StatelessWidget {
  AddTodoPage({super.key});

  final TodoController todoController = Get.find<TodoController>();

  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();

  final RxString _selectedCategory = "Work".obs;
  final List<String> categories = [
    "Work",
    "Study",
    "Personal",
    "Food",
    "Sport",
    "Music"
  ];

  final RxInt _selectedDay = 0.obs;
  final List<String> days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

  final Map<String, IconData> categoryIcons = {
    "Work": Icons.work,
    "Study": Icons.school,
    "Personal": Icons.person,
    "Food": Icons.fastfood,
    "Sport": Icons.sports,
    "Music": Icons.headphones,
  };
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: GestureDetector(
                    onTap: () => Get.back(),
                    child: const Icon(
                      Icons.close_rounded,
                      color: Colors.black,
                      size: 28,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "New Task",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                const Text(
                  "DATE",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 56,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: days.length,
                    itemBuilder: (context, index) {
                      return Obx(() {
                        final isSelected = _selectedDay.value == index;
                        return GestureDetector(
                          onTap: () => _selectedDay.value = index,
                          child: Container(
                            margin: const EdgeInsets.only(right: 12),
                            width: 60,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFF3D5AFE)
                                  : Colors.grey[200],
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Center(
                              child: Text(
                                days[index],
                                style: TextStyle(
                                  color:
                                      isSelected ? Colors.white : Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                    },
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  "PROJECTS",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 12),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final cat = categories[index];
                    return Obx(() {
                      final isSelected = _selectedCategory.value == cat;
                      return GestureDetector(
                        onTap: () => _selectedCategory.value = cat,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF3D5AFE).withOpacity(0.1)
                                : Colors.grey[100],
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFF3D5AFE)
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(categoryIcons[cat],
                                color: const Color(0xFF3D5AFE), size: 22),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  cat,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                                ),
                              ),
                              const Icon(Icons.arrow_forward_ios,
                                size: 16, color: Colors.grey),
                            ],
                          ),
                        ),
                      );
                    });
                  },
                ),
                const SizedBox(height: 24),
                CustomTextField(
                  controller: _titleController,
                  label: "Title",
                ),
                const SizedBox(height: 24),
                CustomButton(
                  myText: "Create",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      todoController.addTodo(
                        _titleController.text,
                        _selectedCategory.value,
                        date: days[_selectedDay.value],
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
}
