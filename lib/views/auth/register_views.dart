import 'package:flutter/material.dart';
import '../../controllers/auth_controller.dart';
import '../home/home_view.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final name = TextEditingController();
  final age = TextEditingController();
  final dob = TextEditingController();

  void register() async {
    await AuthController.register(
      name: name.text,
      age: age.text,
      dob: dob.text,
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => HomeView(userName: name.text)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Register", style: TextStyle(fontSize: 28)),

            TextField(controller: name, decoration: input("Name")),
            TextField(controller: age, decoration: input("Age")),

            TextField(
              controller: dob,
              readOnly: true,
              decoration: input("DOB"),
              onTap: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  firstDate: DateTime(1950),
                  lastDate: DateTime.now(),
                  initialDate: DateTime(2000),
                );

                if (picked != null) {
                  dob.text = "${picked.day}/${picked.month}/${picked.year}";
                }
              },
            ),

            const SizedBox(height: 20),
            ElevatedButton(onPressed: register, child: const Text("Register")),
          ],
        ),
      ),
    );
  }

  InputDecoration input(String hint) {
    return InputDecoration(hintText: hint);
  }
}
