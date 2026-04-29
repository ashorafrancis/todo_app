import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../controllers/avatar_controller.dart';
import '../routes/app_routes.dart';
import '../core/theme.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});

  final authController = Get.find<AuthController>();
  final avatarController = Get.find<AvatarController>();

  void openEditProfile() {
    final user = authController.user.value;

    final nameController = TextEditingController(text: user?.name ?? "");
    final dobController = TextEditingController(text: user?.dob ?? "");

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Edit Profile",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // NAME
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Name",
                prefixIcon: const Icon(Icons.person),
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
                labelText: "Date of Birth",
                prefixIcon: const Icon(Icons.calendar_today),
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
              onTap: () async {
                DateTime? picked = await showDatePicker(
                  context: Get.context!,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1950),
                  lastDate: DateTime.now(),
                );

                if (picked != null) {
                  dobController.text = picked.toString().split(" ")[0];
                }
              },
            ),

            const SizedBox(height: 20),

            // SAVE BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  authController.updateUser(
                    nameController.text,
                    dobController.text,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text("Save Changes"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void openPage(String type) {
    if (type == "tasks") {
      Get.back(); // go back to home (tasks screen)
    } else if (type == "schedule") {
      Get.toNamed(Routes.calendar);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = authController.user.value;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F7),
      body: Column(
        children: [
          // HEADER
          Container(
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 40),
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: AppTheme.gradient,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(35),
                bottomRight: Radius.circular(35),
              ),
            ),
            child: const Text(
              "My Profile",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 25),

          // CARD
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 15),
              ],
            ),
            child: Column(
              children: [
                // AVATAR
                Obx(() {
                  return GestureDetector(
                    onTap: () {
                      avatarController.openAvatarPicker();
                    },
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.deepPurple,
                      child: Icon(
                        avatarController
                            .avatars[avatarController.selectedAvatar.value],
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                  );
                }),

                const SizedBox(height: 15),

                Text(
                  user?.name ?? "No Name",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  user?.dob ?? "No DOB",
                  style: const TextStyle(color: Colors.grey),
                ),

                const SizedBox(height: 20),

                // EDIT BUTTON
                ElevatedButton(
                  onPressed: openEditProfile,
                  child: const Text("Edit Profile"),
                ),

                const SizedBox(height: 20),

                // DASHBOARD
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _item(Icons.task_alt, "Tasks", () {
                      openPage("tasks");
                    }),
                    _item(Icons.calendar_today, "Schedule", () {
                      openPage("schedule");
                    }),
                  ],
                ),

                const SizedBox(height: 25),

                // LOGOUT
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      authController.logout();
                    },
                    style: ElevatedButton.styleFrom(),
                    child: const Text("Logout"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _item(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, color: Colors.deepPurple),
          const SizedBox(height: 5),
          Text(label),
        ],
      ),
    );
  }
}
