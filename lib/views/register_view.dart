import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  final nameCtrl = TextEditingController();
  final dobCtrl = TextEditingController();

  final controller = Get.find<AuthController>();

  Future<void> pickDate() async {
    DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      dobCtrl.text = picked.toString().split(" ")[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF5F2EEA), Color(0xFF8E2DE2)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),

            child: Container(
              padding: const EdgeInsets.all(26),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 25,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),

              child: Column(
                children: [
                  const Icon(
                    Icons.person_add,
                    size: 65,
                    color: Color(0xFF5F2EEA),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    "Create Account",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                  ),

                  const SizedBox(height: 28),

                  // NAME
                  buildField("Name", nameCtrl, Icons.person),

                  const SizedBox(height: 15),

                  // DOB (AGE REMOVED COMPLETELY)
                  TextField(
                    controller: dobCtrl,
                    readOnly: true,
                    onTap: pickDate,
                    style: const TextStyle(fontSize: 15),
                    decoration: inputDecoration(
                      "Date of Birth",
                      Icons.calendar_today,
                    ),
                  ),

                  const SizedBox(height: 28),

                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5F2EEA),
                        elevation: 6,
                        shadowColor: Colors.black38,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {
                        if (nameCtrl.text.isEmpty || dobCtrl.text.isEmpty) {
                          Get.snackbar("Error", "Fill all fields");
                          return;
                        }

                        controller.register(nameCtrl.text, dobCtrl.text);
                      },
                      child: const Text(
                        "Register",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildField(String label, TextEditingController ctrl, IconData icon) {
    return TextField(
      controller: ctrl,
      style: const TextStyle(fontSize: 15),
      decoration: inputDecoration(label, icon),
    );
  }

  InputDecoration inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: const Color(0xFF5F2EEA)),
      filled: true,
      fillColor: const Color(0xFFF6F7FB),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Color(0xFF5F2EEA), width: 1.2),
      ),
    );
  }
}
