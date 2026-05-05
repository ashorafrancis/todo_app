import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../core/theme.dart';

Future<DateTime?> customDatePicker(
  BuildContext context,
  DateTime initialDate, {
  bool disablePast = false,
  bool disableFuture = false,
}) {
  DateTime selectedDate = initialDate;
  DateTime focusedDay = initialDate;

  return showModalBottomSheet<DateTime>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 50,
                  height: 5,
                  margin: const EdgeInsets.only(bottom: 15),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const Text(
                  "Select Date",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                TableCalendar(
                  firstDay: DateTime(1900),
                  lastDay: DateTime(2100),
                  focusedDay: focusedDay,

                  // ✅ SWITCH BETWEEN MODES
                  enabledDayPredicate: (day) {
                    final today = DateTime.now();

                    final cleanToday =
                        DateTime(today.year, today.month, today.day);
                    final cleanDay = DateTime(day.year, day.month, day.day);

                    if (disablePast) {
                      return !cleanDay.isBefore(cleanToday); // ✅ FIXED
                    }

                    if (disableFuture) {
                      return !cleanDay.isAfter(cleanToday); // ✅ FIXED
                    }

                    return true;
                  },

                  selectedDayPredicate: (day) => isSameDay(selectedDate, day),

                  onDaySelected: (selected, focused) {
                    setState(() {
                      selectedDate = selected;
                      focusedDay = focused;
                    });
                  },

                  headerStyle: const HeaderStyle(
                    titleCentered: true,
                    formatButtonVisible: false,
                  ),

                  calendarStyle: CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: AppTheme.primary.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: const BoxDecoration(
                      color: AppTheme.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, selectedDate);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primary,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text("Confirm"),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
