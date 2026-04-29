import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/theme.dart';
import '../views/home_view.dart';
import '../screens/calendar_view.dart';
import '../widgets/add_task_sheet.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index = 0;

  final pages = [HomeView(), const CalendarView()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bg,
      body: pages[index],

      // ✅ FIXED ADD BUTTON
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.primary,
        child: const Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) => const AddTaskSheet(),
          );
        },
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        selectedItemColor: AppTheme.primary,
        onTap: (i) => setState(() => index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Tasks"),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: "Calendar",
          ),
        ],
      ),
    );
  }
}
