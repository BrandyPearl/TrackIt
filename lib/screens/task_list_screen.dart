import 'package:flutter/material.dart';

import '../models/task.dart';
import '../widgets/task_card.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {

  // TEXT CONTROLLERS
  final TextEditingController titleController =
      TextEditingController();

  final TextEditingController descriptionController =
      TextEditingController();

  // DROPDOWN VARIABLES
  String selectedCategory = "School";
  String selectedPriority = "Low";

  // DATE VARIABLE
  DateTime selectedDate = DateTime.now();

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

      // TASK LIST
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

          // DISPLAY TASKS
          : ListView.builder(

              itemCount: tasks.length,

              itemBuilder: (context, index) {

                return TaskCard(
                  task: tasks[index],
                );
              },
            ),

      // FLOATING ACTION BUTTON
      floatingActionButton: FloatingActionButton(

        onPressed: () {
          showAddTaskBottomSheet();
        },

        child: const Icon(Icons.add),
      ),
    );
  }

  // BOTTOM SHEET METHOD
  void showAddTaskBottomSheet() {

    showModalBottomSheet(
      context: context,

      isScrollControlled: true,

      builder: (context) {

        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,

            bottom:
                MediaQuery.of(context).viewInsets.bottom + 20,
          ),

          child: SingleChildScrollView(

            child: Column(
              mainAxisSize: MainAxisSize.min,

              children: [

                const Text(
                  "Add New Task",

                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                // TITLE FIELD
                TextField(
                  controller: titleController,

                  decoration: const InputDecoration(
                    labelText: "Task Title",
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 15),

                // DESCRIPTION FIELD
                TextField(
                  controller: descriptionController,
                  maxLines: 3,

                  decoration: const InputDecoration(
                    labelText: "Description",
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 15),

                // CATEGORY DROPDOWN
                DropdownButtonFormField(

                  value: selectedCategory,

                  items: const [

                    DropdownMenuItem(
                      value: "School",
                      child: Text("School"),
                    ),

                    DropdownMenuItem(
                      value: "Personal",
                      child: Text("Personal"),
                    ),

                    DropdownMenuItem(
                      value: "Health",
                      child: Text("Health"),
                    ),
                  ],

                  onChanged: (value) {

                    setState(() {
                      selectedCategory = value!;
                    });
                  },

                  decoration: const InputDecoration(
                    labelText: "Category",
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 15),

                // PRIORITY DROPDOWN
                DropdownButtonFormField(

                  value: selectedPriority,

                  items: const [

                    DropdownMenuItem(
                      value: "Low",
                      child: Text("Low"),
                    ),

                    DropdownMenuItem(
                      value: "Medium",
                      child: Text("Medium"),
                    ),

                    DropdownMenuItem(
                      value: "High",
                      child: Text("High"),
                    ),
                  ],

                  onChanged: (value) {

                    setState(() {
                      selectedPriority = value!;
                    });
                  },

                  decoration: const InputDecoration(
                    labelText: "Priority",
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 15),

                // DATE PICKER BUTTON
                ElevatedButton.icon(

                  onPressed: () async {

                    DateTime? pickedDate =
                        await showDatePicker(

                      context: context,

                      firstDate: DateTime.now(),

                      lastDate: DateTime(2030),

                      initialDate: selectedDate,
                    );

                    if (pickedDate != null) {

                      setState(() {
                        selectedDate = pickedDate;
                      });
                    }
                  },

                  icon: const Icon(Icons.calendar_month),

                  label: Text(
                    "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                  ),
                ),

                const SizedBox(height: 25),

                // ADD TASK BUTTON
                SizedBox(
                  width: double.infinity,

                  child: ElevatedButton(

                    onPressed: () {

                      // VALIDATION
                      if (titleController.text.isEmpty ||
                          descriptionController.text.isEmpty) {

                        ScaffoldMessenger.of(context)
                            .showSnackBar(

                          const SnackBar(
                            content: Text(
                              "Please fill all fields",
                            ),
                          ),
                        );

                        return;
                      }

                      // ADD TASK
                      setState(() {

                        tasks.add(
                          Task(
                            title: titleController.text,

                            description:
                                descriptionController.text,

                            category: selectedCategory,

                            priority: selectedPriority,

                            dueDate: selectedDate,
                          ),
                        );
                      });

                      // CLEAR FIELDS
                      titleController.clear();
                      descriptionController.clear();

                      // CLOSE BOTTOM SHEET
                      Navigator.pop(context);
                    },

                    child: const Text("Add Task"),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}