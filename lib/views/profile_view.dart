import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';
import '../controllers/auth_controller.dart';
import '../ui/app_ui.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});

  final profileController = Get.find<ProfileController>();
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppUI.bg,

      body: Column(
        children: [
          Container(
            height: 220,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF6C5CE7), Color(0xFF8E44AD)],
              ),
            ),
            child: Center(
              child: Obx(
                () => GestureDetector(
                  onTap: profileController.openAvatarPicker,
                  child: CircleAvatar(
                    radius: 55,
                    backgroundColor: Colors.white,
                    child: Icon(
                      profileController.avatars[profileController
                          .selectedAvatar
                          .value],
                      size: 45,
                      color: AppUI.primary,
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          Obx(
            () => Text(
              authController.user.value?.name ?? "",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(height: 5),

          Obx(
            () => Text(
              "DOB: ${authController.user.value?.dob ?? ""}",
              style: const TextStyle(color: Colors.grey),
            ),
          ),

          const SizedBox(height: 25),

          Container(
            margin: const EdgeInsets.all(16),
            decoration: AppUI.card,
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.edit),
                  title: const Text("Edit Profile"),
                  onTap: profileController.openEditProfileDialog,
                ),

                const Divider(height: 0),

                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: const Text("Logout"),
                  onTap: authController.logout,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
