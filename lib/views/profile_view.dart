import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/auth_controller.dart';

class ProfileView extends StatefulWidget {
  ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final controller = Get.find<AuthController>();

  int selectedAvatar = 0;

  final List<IconData> avatars = [
    Icons.person,
    Icons.person_2,
    Icons.person_3,
    Icons.face,
    Icons.sentiment_satisfied,
    Icons.tag_faces,
  ];

  @override
  void initState() {
    super.initState();
    loadAvatar();
  }

  // 🔥 LOAD AVATAR
  Future<void> loadAvatar() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedAvatar = prefs.getInt("avatar") ?? 0;
    });
  }

  // 🔥 SAVE AVATAR
  Future<void> saveAvatar(int index) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("avatar", index);

    setState(() {
      selectedAvatar = index;
    });

    Navigator.pop(context);
  }

  void openAvatarPicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Wrap(
            spacing: 15,
            children: List.generate(avatars.length, (index) {
              return GestureDetector(
                onTap: () => saveAvatar(index),
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: const Color(0xFF5F2EEA).withOpacity(0.1),
                  child: Icon(
                    avatars[index],
                    size: 30,
                    color: const Color(0xFF5F2EEA),
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }

  void editProfileDialog() {
    final user = controller.user.value;

    final nameCtrl = TextEditingController(text: user?.name ?? "");
    final ageCtrl = TextEditingController(text: user?.age ?? "");
    final dobCtrl = TextEditingController(text: user?.dob ?? "");

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
      radius: 15,
      title: "Edit Profile",
      content: Column(
        children: [
          buildField("Name", nameCtrl),
          buildField("Age", ageCtrl, isNumber: true),
          GestureDetector(
            onTap: pickDate,
            child: AbsorbPointer(
              child: TextField(
                controller: dobCtrl,
                decoration: inputDecoration("Date of Birth"),
              ),
            ),
          ),
        ],
      ),
      textConfirm: "Save",
      textCancel: "Cancel",
      confirmTextColor: Colors.white,
      buttonColor: const Color(0xFF5F2EEA),
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
          // 🔥 MODERN HEADER (ONLY AVATAR CHANGED)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 30),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF5F2EEA), Color(0xFF8E2DE2)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(35),
                bottomRight: Radius.circular(35),
              ),
            ),
            child: Column(
              children: [
                GestureDetector(
                  onTap: openAvatarPicker,
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.white,
                      child: Icon(
                        avatars[selectedAvatar],
                        size: 45,
                        color: const Color(0xFF5F2EEA),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  user?.name?.isNotEmpty == true ? user!.name : "No Name",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Welcome back 👋",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          // 📦 INFO CARD (UNCHANGED)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                buildRow(Icons.cake, "Age", user?.age ?? ""),
                const Divider(),
                buildRow(Icons.calendar_month, "DOB", user?.dob ?? ""),
              ],
            ),
          ),

          const Spacer(),

          // 🎯 BUTTONS (UNCHANGED)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5F2EEA),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 3,
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
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: controller.logout,
                  icon: const Icon(Icons.logout, color: Colors.white),
                  label: const Text(
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

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget buildRow(IconData icon, String title, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey),
        const SizedBox(width: 10),
        Text(title, style: const TextStyle(color: Colors.grey)),
        const Spacer(),
        Text(
          value.isEmpty ? "-" : value,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
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
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }
}
