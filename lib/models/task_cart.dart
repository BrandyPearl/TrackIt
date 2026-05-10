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

      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: getPriorityColor(),
          child: const Icon(
            Icons.task,
            color: Colors.white,
          ),
        ),

        title: Text(
          task.title,

          style: TextStyle(
            fontWeight: FontWeight.bold,
            decoration: task.isCompleted
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),

        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(task.category),

            Text(
              "Due: ${task.dueDate.day}/${task.dueDate.month}/${task.dueDate.year}",
            ),
          ],
        ),

        trailing: Icon(
          task.isCompleted
              ? Icons.check_circle
              : Icons.radio_button_unchecked,

          color: task.isCompleted
              ? Colors.green
              : Colors.grey,
        ),
      ),
    );
  }
}