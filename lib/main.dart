import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const RegisterScreen(),
    );
  }
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final dobController = TextEditingController();

  void register() {
    String name = nameController.text.trim();
    String age = ageController.text.trim();
    String dob = dobController.text.trim();

    // ✅ Empty validation
    if (name.isEmpty || age.isEmpty || dob.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
      return;
    }

    // ✅ Age validation
    if (int.tryParse(age) == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Enter valid age")));
      return;
    }

    // ✅ Navigate to Home
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen(userName: name)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Register",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 30),

                // 👤 Name
                TextField(
                  controller: nameController,
                  decoration: inputStyle("Name"),
                ),

                const SizedBox(height: 10),

                // 🔢 Age
                TextField(
                  controller: ageController,
                  keyboardType: TextInputType.number,
                  decoration: inputStyle("Age"),
                ),

                const SizedBox(height: 10),

                // 📅 Date of Birth
                TextField(
                  controller: dobController,
                  readOnly: true,
                  decoration: inputStyle("Date of Birth"),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime(2000),
                      firstDate: DateTime(1950),
                      lastDate: DateTime.now(),
                    );

                    if (pickedDate != null) {
                      setState(() {
                        dobController.text =
                            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                      });
                    }
                  },
                ),

                const SizedBox(height: 20),

                // 🔘 Register Button
                ElevatedButton(
                  onPressed: register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                  ),
                  child: const Text("Register"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// 🎨 Input Style
InputDecoration inputStyle(String hint) {
  return InputDecoration(
    hintText: hint,
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    ),
  );
}

// 🏠 Home Screen
class HomeScreen extends StatelessWidget {
  final String userName;

  const HomeScreen({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome $userName"),
        backgroundColor: Colors.deepPurple,
      ),
      body: const Center(child: Text("Home Screen (To-Do UI coming next)")),
    );
  }
}
