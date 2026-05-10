import 'package:flutter/material.dart';

import '../models/task.dart';
import '../widgets/task_card.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {

  // SAMPLE TASKS
  List<Task> tasks = [

    Task(
      title: "Complete Flutter Assignment",
      description: "Finish task manager app project",
      category: "School",
      priority: "High",
      dueDate: DateTime(2026, 5, 16),
    ),

    Task(
      title: "Go To Gym",
      description: "Leg day workout session",
      category: "Health",
      priority: "Medium",
      dueDate: DateTime(2026, 5, 10),
    ),

    Task(
      title: "Read Software Engineering Notes",
      description: "Prepare for upcoming test",
      category: "Study",
      priority: "Low",
      dueDate: DateTime(2026, 5, 12),
      isCompleted: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text("Task Manager"),
      ),

      body: tasks.isEmpty

          // EMPTY STATE
          ? const Center(
              child: Text(
                "No tasks available",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            )

          // TASK LIST
          : ListView.builder(
              itemCount: tasks.length,

              itemBuilder: (context, index) {

                return TaskCard(
                  task: tasks[index],
                );
              },
            ),
    );
  }
}