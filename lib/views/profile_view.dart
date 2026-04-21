import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class ProfileView extends StatelessWidget {
  final controller = Get.find<AuthController>();

  void editProfileDialog() {
    final user = controller.user.value;

    final nameCtrl = TextEditingController(text: user?.name);
    final ageCtrl = TextEditingController(text: user?.age);
    final dobCtrl = TextEditingController(text: user?.dob);

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

    Get.defaultDialog(
      title: "Edit Profile",
      content: Column(
        children: [
          buildField("Name", nameCtrl),
          buildField("Age", ageCtrl, isNumber: true),
          TextField(
            controller: dobCtrl,
            readOnly: true,
            onTap: pickDate,
            decoration: inputDecoration("Date of Birth"),
          ),
        ],
      ),
      textConfirm: "Save",
      textCancel: "Cancel",
      onConfirm: () {
        if (nameCtrl.text.isEmpty ||
            ageCtrl.text.isEmpty ||
            dobCtrl.text.isEmpty) {
          Get.snackbar("Error", "Fill all fields");
          return;
        }

        controller.register(nameCtrl.text, ageCtrl.text, dobCtrl.text);

        Get.back();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = controller.user.value;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      body: Column(
        children: [
          // HEADER
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 25),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF5F2EEA), Color(0xFF8E2DE2)],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 40, color: Color(0xFF5F2EEA)),
                ),
                const SizedBox(height: 10),
                Text(
                  user?.name ?? "",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // DETAILS CARD
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                buildRow("Age", user?.age ?? ""),
                const Divider(),
                buildRow("DOB", user?.dob ?? ""),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5F2EEA),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: editProfileDialog,
                  icon: const Icon(Icons.edit, color: Colors.white),
                  label: const Text(
                    "Edit Profile",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: controller.logout,
                  child: const Text(
                    "Logout",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(color: Colors.grey)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget buildField(
    String label,
    TextEditingController ctrl, {
    bool isNumber = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: ctrl,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: inputDecoration(label),
      ),
    );
  }

  InputDecoration inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.grey[100],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
    );
  }
}
