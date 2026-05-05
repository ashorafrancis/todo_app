import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/widgets/custom_date_picker.dart';
import '../controllers/auth_controller.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    final nameController = TextEditingController();
    final dobController = TextEditingController();

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 37, 99, 235),
              Color.fromARGB(255, 96, 165, 250)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(25),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 37, 99, 235),
                        Color.fromARGB(255, 96, 165, 250)
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF2563EB).withOpacity(0.3),
                        blurRadius: 15,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.person,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 15),

                const Text(
                  "Register",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 25),

                // NAME
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person_outline),
                    hintText: "Enter your name",
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // DOB
                TextField(
                  controller: dobController,
                  readOnly: true,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.calendar_today),
                    hintText: "Date of Birth",
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onTap: () async {
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime(2000),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(), // ❌ blocks future
                      initialDatePickerMode:
                          DatePickerMode.year, // ✅ fast year selection
                    );

                    if (picked != null) {
                      dobController.text = picked.toString().split(" ")[0];
                    }
                  },
                ),

                const SizedBox(height: 25),

                // SIGN UP BUTTON (FIXED NAV)
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 37, 99, 235),
                        Color.fromARGB(255, 96, 165, 250)
                      ],
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      authController.register(
                        nameController.text,
                        dobController.text,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text("Register"),
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
