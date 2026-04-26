import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AvatarController extends GetxController {
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

  // ✅ Dialog moved here
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
}
