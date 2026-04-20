import 'package:flutter/material.dart';
import '../services/storage_service.dart';
import 'register_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = StorageService.getUser();

    if (user == null) {
      return const Scaffold(body: Center(child: Text("No user data found")));
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF11998e), Color(0xFF38ef7d)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Name: ${user.name}",
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
              Text(
                "Age: ${user.age}",
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
              Text(
                "Date of Birth: ${user.dob}",
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  StorageService.logout();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const RegisterPage()),
                    (route) => false,
                  );
                },
                child: const Text("Logout"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
