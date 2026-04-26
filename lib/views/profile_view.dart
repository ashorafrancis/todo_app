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

  // 🔥 AVATAR PICKER
  void openAvatarPicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Wrap(
            spacing: 20,
            runSpacing: 20,
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

  // 🔥 EDIT PROFILE
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
      title: "Edit Profile",
      content: Column(
        children: [
          TextField(
            controller: nameCtrl,
            decoration: const InputDecoration(labelText: "Name"),
          ),
          TextField(
            controller: ageCtrl,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: "Age"),
          ),
          TextField(
            controller: dobCtrl,
            readOnly: true,
            onTap: pickDate,
            decoration: const InputDecoration(labelText: "DOB"),
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
      backgroundColor: const Color(0xFFF2F3F7),
      body: Stack(
        children: [
          // 🔥 TOP GRADIENT
          Container(
            height: 220,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF5F2EEA), Color(0xFF8E2DE2)],
              ),
            ),
          ),

          // 🔥 CONTENT
          Column(
            children: [
              const SizedBox(height: 140),

              Expanded(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 80, 20, 20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        user?.name ?? "No Name",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 20),

                      buildRow(Icons.cake, "Age", user?.age ?? ""),
                      const Divider(),
                      buildRow(Icons.calendar_month, "DOB", user?.dob ?? ""),

                      const Spacer(),

                      // ✏️ EDIT BUTTON
                      ElevatedButton.icon(
                        onPressed: editProfileDialog,
                        icon: const Icon(Icons.edit, color: Colors.white),
                        label: const Text(
                          "Edit Profile",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF5F2EEA),
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // 🔥 LIGHTER LOGOUT BUTTON
                      ElevatedButton.icon(
                        onPressed: controller.logout,
                        icon: const Icon(Icons.logout, color: Colors.black87),
                        label: const Text(
                          "Logout",
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade200, // ✅ lighter
                          elevation: 0,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // 🔥 AVATAR
          Positioned(
            top: 100,
            left: MediaQuery.of(context).size.width / 2 - 50,
            child: GestureDetector(
              onTap: openAvatarPicker,
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                child: Icon(
                  avatars[selectedAvatar],
                  size: 50,
                  color: const Color(0xFF5F2EEA),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey),
          const SizedBox(width: 10),
          Text(title),
          const Spacer(),
          Text(
            value.isEmpty ? "-" : value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
