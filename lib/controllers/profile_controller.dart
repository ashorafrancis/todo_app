import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../models/user_model.dart';
import 'auth_controller.dart';

class ProfileController extends GetxController {
  late final AuthController authController;

  var selectedAvatar = 0.obs;

  final avatars = [
    Icons.person,
    Icons.person_2,
    Icons.person_3,
    Icons.face,
    Icons.sentiment_satisfied,
    Icons.tag_faces,
  ];

  @override
  void onInit() {
    super.onInit();
    authController = Get.find<AuthController>();
    loadAvatar();
  }

  void loadAvatar() async {
    final prefs = await SharedPreferences.getInstance();
    selectedAvatar.value = prefs.getInt("avatar") ?? 0;
  }

  void setAvatar(int index) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("avatar", index);
    selectedAvatar.value = index;
  }

  void openAvatarPicker() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        color: Colors.white,
        child: Wrap(
          spacing: 20,
          children: List.generate(avatars.length, (index) {
            return GestureDetector(
              onTap: () {
                setAvatar(index);
                Get.back();
              },
              child: CircleAvatar(child: Icon(avatars[index])),
            );
          }),
        ),
      ),
    );
  }

  // ✅ DATE PICKER MOVED HERE
  Future<void> pickDate(TextEditingController ctrl) async {
    DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      ctrl.text = picked.toString().split(" ")[0];
    }
  }

  // ✅ EDIT PROFILE (NO LOGIC IN VIEW)
  void openEditProfileDialog() {
    final user = authController.user.value;

    final nameCtrl = TextEditingController(text: user?.name ?? "");
    final ageCtrl = TextEditingController(text: user?.age ?? "");
    final dobCtrl = TextEditingController(text: user?.dob ?? "");

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
            onTap: () => pickDate(dobCtrl),
            decoration: const InputDecoration(labelText: "DOB"),
          ),
        ],
      ),
      onConfirm: () async {
        if (nameCtrl.text.isEmpty ||
            ageCtrl.text.isEmpty ||
            dobCtrl.text.isEmpty) {
          Get.snackbar("Error", "Fill all fields");
          return;
        }

        final updatedUser = UserModel(
          name: nameCtrl.text,
          age: ageCtrl.text,
          dob: dobCtrl.text,
        );

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("user", jsonEncode(updatedUser.toJson()));

        authController.user.value = updatedUser;

        Get.back();
      },
    );
  }
}
