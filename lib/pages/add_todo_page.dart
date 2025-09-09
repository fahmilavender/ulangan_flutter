import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ulangan_flutter/components/custom_button.dart';
import 'package:ulangan_flutter/components/custom_textfield.dart';
import 'package:ulangan_flutter/components/dropdowncustom.dart';
import '../controllers/todo_controller.dart';

class AddTodoPage extends StatelessWidget {
  AddTodoPage({super.key});

  final TodoController todoController = Get.find<TodoController>();

  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final RxString _selectedCategory = "Pekerjaan".obs;

  final List<String> categories = ["Pekerjaan", "Belajar", "Pribadi"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Todo")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Input Judul
              CustomTextField(controller: _titleController, label: "Judul"),
              const SizedBox(height: 16),

              // Input Deskripsi
              CustomTextField(controller: _descController, label: "Deskripsi"),
              const SizedBox(height: 16),

              // Dropdown Kategori
              Obx(() {
                return Dropdowncustom(
                  items: categories,
                  value: _selectedCategory.value,
                  hintText: "Pilih kategori",
                  onChanged: (val) {
                    if (val != null) _selectedCategory.value = val;
                  },
                );
              }),
              const SizedBox(height: 24),

              // Tombol Simpan
              CustomButton(
                myText: "Simpan",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    todoController.addTodo(
                      _titleController.text,
                      _descController.text,
                      _selectedCategory.value,
                    );
                    Get.back();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
