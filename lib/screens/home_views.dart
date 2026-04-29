import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../widgets/task_tile.dart';
import '../widgets/section_title.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
          decoration: const BoxDecoration(
            gradient: AppTheme.gradient,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
          ),
          child: Column(
            children: [
              Row(
                children: const [
                  Icon(Icons.grid_view, color: Colors.white),
                  Spacer(),
                  CircleAvatar(
                    backgroundColor: Colors.white24,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    hintStyle: TextStyle(color: Colors.white70),
                    border: InputBorder.none,
                    icon: Icon(Icons.search, color: Colors.white),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),

        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: const [
              SectionTitle("Today"),
              TaskTile("Schedule dentist appointment", ["Health"]),
              TaskTile("Prepare Team Meeting", ["Work", "Urgent"]),

              SectionTitle("Tomorrow"),
              TaskTile("Call Charlotte", ["Personal"]),
              TaskTile("Submit exercise 3.1", ["Study"]),

              SectionTitle("This Week"),
              TaskTile("Prepare AI Test", ["Study", "Important"]),
            ],
          ),
        ),
      ],
    );
  }
}
