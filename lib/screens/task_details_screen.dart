import 'package:flutter/material.dart';

import '../models/task.dart';

class TaskDetailScreen extends StatefulWidget {

  final Task task;

  const TaskDetailScreen({
    super.key,
    required this.task,
  });

  @override
  State<TaskDetailScreen> createState() =>
      _TaskDetailScreenState();
}

class _TaskDetailScreenState
    extends State<TaskDetailScreen> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Task Details"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            Text(
              widget.task.title,

              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Card(
              elevation: 4,

              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(16),
              ),

              child: Padding(
                padding: const EdgeInsets.all(16),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    const Row(
                      children: [

                        Icon(
                          Icons.description,
                          color: Color(0xFF8C13AA),
                        ),

                        SizedBox(width: 10),

                        Text(
                          "Description",

                          style: TextStyle(
                            fontSize: 18,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 10),

                    Text(
                      widget.task.description,

                      style: TextStyle(
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            Card(
              elevation: 4,

              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(16),
              ),

              child: Padding(
                padding: const EdgeInsets.all(16),

                child: Column(
                  children: [

                    buildInfoRow(
                      Icons.category,
                      "Category",
                      widget.task.category,
                    ),

                    const SizedBox(height: 15),

                    buildInfoRow(
                      Icons.priority_high,
                      "Priority",
                      widget.task.priority,
                    ),

                    const SizedBox(height: 15),

                    buildInfoRow(
                      Icons.calendar_month,
                      "Due Date",

                      "${widget.task.dueDate.day}/"
                      "${widget.task.dueDate.month}/"
                      "${widget.task.dueDate.year}",
                    ),

                    const SizedBox(height: 15),

                    buildInfoRow(
                      Icons.check_circle,
                      "Status",

                      widget.task.isCompleted
                          ? "Completed"
                          : "Pending",
                    ),
                  ],
                ),
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton.icon(

                onPressed: () {

                  setState(() {

                    widget.task.isCompleted =
                        !widget.task.isCompleted;
                  });
                },

                icon: Icon(

                  widget.task.isCompleted
                      ? Icons.undo
                      : Icons.check,
                ),

                label: Text(

                  widget.task.isCompleted
                      ? "Mark Incomplete"
                      : "Mark Complete",
                ),
              ),
            ),

            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton.icon(

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),

                onPressed: () {
                  showDeleteDialog();
                },

                icon: const Icon(Icons.delete),

                label: const Text("Delete Task"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInfoRow(
    IconData icon,
    String title,
    String value,
  ) {

    return Row(
      children: [

        Icon(
          icon,
          color: const Color(0xFF8C13AA),
        ),

        const SizedBox(width: 10),

        Text(
          "$title: ",

          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),

        Expanded(
          child: Text(
            value,

            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }

  void showDeleteDialog() {

    showDialog(
      context: context,

      builder: (context) {

        return AlertDialog(

          title: const Text("Delete Task"),

          content: const Text(
            "Are you sure you want to delete this task?",
          ),

          actions: [

            TextButton(
              onPressed: () {

                Navigator.pop(context);
              },

              child: const Text("Cancel"),
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),

              onPressed: () {

                Navigator.pop(context);
                Navigator.pop(context);
              },

              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }
}