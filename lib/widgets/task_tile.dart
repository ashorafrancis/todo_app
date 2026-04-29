import 'package:flutter/material.dart';
import '../core/app_ui.dart';

class TaskTile extends StatelessWidget {
  final String title;
  final List<String> tags;
  final bool isDone;

  const TaskTile(
    this.title,
    this.tags, {
    super.key,
    this.isDone = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: AppUI.cardDecoration,
      child: Row(
        children: [
          // CHECK ICON
          Icon(
            isDone ? Icons.check_circle : Icons.circle_outlined,
            color: isDone ? AppUI.accent : Colors.grey,
          ),

          const SizedBox(width: 12),

          // TITLE + TAGS
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    decoration: isDone ? TextDecoration.lineThrough : null,
                    color: isDone ? Colors.grey : const Color(0xFF2D3436),
                  ),
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 6,
                  children: tags.map((t) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: AppUI.primary.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        t,
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppUI.primary,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          const Icon(Icons.more_horiz, color: Colors.grey),
        ],
      ),
    );
  }
}
