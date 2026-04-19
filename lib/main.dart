import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'services/auth_service.dart';

void main() {
  runApp(const MyApp());
}

/* ---------------- APP ROOT ---------------- */

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashCheck(),
    );
  }
}

/* ---------------- SPLASH CHECK ---------------- */

class SplashCheck extends StatefulWidget {
  const SplashCheck({super.key});

  @override
  State<SplashCheck> createState() => _SplashCheckState();
}

class _SplashCheckState extends State<SplashCheck> {
  @override
  void initState() {
    super.initState();
    checkUser();
  }

  void checkUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? name = prefs.getString("user_name");

    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    // 🔥 SAFE NAVIGATION FIX
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (name != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen(userName: name)),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const RegisterScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}

/* ---------------- REGISTER SCREEN ---------------- */

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final dobController = TextEditingController();

  void register() async {
    String name = nameController.text.trim();
    String age = ageController.text.trim();
    String dob = dobController.text.trim();

    if (name.isEmpty || age.isEmpty || dob.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Fill all fields")));
      return;
    }

    await AuthService.registerUser(name: name, age: age, dob: dob);

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen(userName: name)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Register",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              TextField(
                controller: nameController,
                decoration: inputStyle("Name"),
              ),

              const SizedBox(height: 10),

              TextField(
                controller: ageController,
                keyboardType: TextInputType.number,
                decoration: inputStyle("Age"),
              ),

              const SizedBox(height: 10),

              TextField(
                controller: dobController,
                readOnly: true,
                decoration: inputStyle("DOB"),
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime(2000),
                    firstDate: DateTime(1950),
                    lastDate: DateTime.now(),
                  );

                  if (picked != null) {
                    setState(() {
                      dobController.text =
                          "${picked.day}/${picked.month}/${picked.year}";
                    });
                  }
                },
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: register,
                child: const Text("Register"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/* ---------------- INPUT STYLE ---------------- */

InputDecoration inputStyle(String hint) {
  return InputDecoration(
    hintText: hint,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
  );
}

/* ---------------- HOME SCREEN ---------------- */

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
      body: const Center(child: Text("Home Screen")),
    );
  }
}
