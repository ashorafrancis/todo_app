import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';
import '../controllers/auth_controller.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});

  final profileController = Get.find<ProfileController>();
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),

      body: Stack(
        children: [
          Container(
            height: 220,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF6C2BD9), Color(0xFF7C3AED)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          Column(
            children: [
              const SizedBox(height: 120),

              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(20, 70, 20, 20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(35),
                    ),
                  ),

                  child: Column(
                    children: [
                      Obx(() {
                        final user = authController.user.value;
                        return Text(
                          user?.name ?? "No Name",
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }),

                      const SizedBox(height: 25),

                      Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF9FAFB),
                          borderRadius: BorderRadius.circular(18),
                        ),

                        child: Obx(() {
                          final user = authController.user.value;

                          return Column(
                            children: [
                              // ❌ AGE REMOVED COMPLETELY
                              _row(
                                Icons.calendar_month,
                                "DOB",
                                user?.dob ?? "",
                              ),
                            ],
                          );
                        }),
                      ),

                      const Spacer(),

                      ElevatedButton.icon(
                        onPressed: profileController.openEditProfileDialog,
                        icon: const Icon(Icons.edit),
                        label: const Text("Edit Profile"),
                      ),

                      const SizedBox(height: 12),

                      ElevatedButton.icon(
                        onPressed: authController.logout,
                        icon: const Icon(Icons.logout),
                        label: const Text("Logout"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Positioned(
            top: 80,
            left: MediaQuery.of(context).size.width / 2 - 55,
            child: Obx(
              () => GestureDetector(
                onTap: profileController.openAvatarPicker,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: CircleAvatar(
                    radius: 55,
                    backgroundColor: Colors.white,
                    child: Icon(
                      profileController.avatars[profileController
                          .selectedAvatar
                          .value],
                      size: 55,
                      color: const Color(0xFF6C2BD9),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _row(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF6C2BD9)),
          const SizedBox(width: 12),
          Text(title),
          const Spacer(),
          Text(
            value.isEmpty ? "-" : value,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
