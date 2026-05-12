import 'package:flutter/material.dart';

import '../models/task.dart';

class TaskCard extends StatelessWidget {

  final Task task;

  const TaskCard({
    super.key,
    required this.task,
  });

  Color getPriorityColor() {

    switch (task.priority) {

      case "High":
        return Colors.red;

      case "Medium":
        return Colors.orange;

      default:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {

    return Card(

      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),

      elevation: 4,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),

      child: Padding(
        padding: const EdgeInsets.all(12),

        child: Row(
          children: [

            CircleAvatar(
              backgroundColor: getPriorityColor(),

              child: const Icon(
                Icons.task,
                color: Colors.white,
              ),
            ),

            const SizedBox(width: 15),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Text(
                    task.title,

                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,

                      decoration: task.isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    "Category: ${task.category}",

                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),

                  const SizedBox(height: 5),

                  // DUE DATE
                  Text(
                    "Due: ${task.dueDate.day}/${task.dueDate.month}/${task.dueDate.year}",

                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            
            Icon(
              task.isCompleted
                  ? Icons.check_circle
                  : Icons.radio_button_unchecked,

              color: task.isCompleted
                  ? Colors.green
                  : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}