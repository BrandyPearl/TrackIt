import 'package:flutter/material.dart';

import '../models/task.dart';
import '../widgets/task_card.dart';
import 'task_details_screen.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() =>
      _TaskListScreenState();
}

class _TaskListScreenState
    extends State<TaskListScreen> {

  final TextEditingController titleController =
      TextEditingController();

  final TextEditingController descriptionController =
      TextEditingController();

  final TextEditingController searchController =
      TextEditingController();

  String currentFilter = "All";

  String selectedCategory = "School";
  String selectedPriority = "Low";

  DateTime selectedDate = DateTime.now();

  List<Task> tasks = [

    Task(
      title: "Complete Flutter Assignment",
      description:
          "Finish task manager mobile app",
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
      title: "Read Software Notes",
      description:
          "Prepare for upcoming software engineering test",
      category: "School",
      priority: "Low",
      dueDate: DateTime(2026, 5, 12),
      isCompleted: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {

    List<Task> filteredTasks = tasks;

    if (currentFilter == "Pending") {

      filteredTasks = tasks.where((task) {

        return task.isCompleted == false;

      }).toList();

    } else if (currentFilter == "Completed") {

      filteredTasks = tasks.where((task) {

        return task.isCompleted == true;

      }).toList();
    }

    if (searchController.text.isNotEmpty) {

      filteredTasks =
          filteredTasks.where((task) {

        return task.title
            .toLowerCase()
            .contains(
              searchController.text.toLowerCase(),
            );

      }).toList();
    }

    int totalTasks = tasks.length;

    int completedTasks =
        tasks.where((task) {

      return task.isCompleted;

    }).length;

    int pendingTasks =
        totalTasks - completedTasks;

    double progress = totalTasks == 0
        ? 0
        : completedTasks / totalTasks;

    return Scaffold(

      appBar: AppBar(

        title: const Text("Task Manager"),

        actions: [

          IconButton(

            onPressed: () {
              showSearchDialog();
            },

            icon: const Icon(Icons.search),
          ),

          IconButton(

            onPressed: () {
              showClearAllDialog();
            },

            icon: const Icon(Icons.delete_sweep),
          ),

          PopupMenuButton<String>(

            onSelected: (value) {

              setState(() {

                if (value == "Due Date") {

                  tasks.sort((a, b) {

                    return a.dueDate.compareTo(
                      b.dueDate,
                    );
                  });

                } else {

                  tasks.sort((a, b) {

                    Map<String, int>
                        priorityOrder = {

                      "High": 3,
                      "Medium": 2,
                      "Low": 1,
                    };

                    return priorityOrder[
                            b.priority]!
                        .compareTo(
                      priorityOrder[
                          a.priority]!,
                    );
                  });
                }
              });
            },

            itemBuilder: (context) => [

              const PopupMenuItem(
                value: "Due Date",

                child: Text(
                  "Sort by Due Date",
                ),
              ),

              const PopupMenuItem(
                value: "Priority",

                child: Text(
                  "Sort by Priority",
                ),
              ),
            ],
          ),
        ],
      ),

      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(16),

            child: Card(

              elevation: 4,

              shape:
                  RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(
                  16,
                ),
              ),

              child: Padding(
                padding:
                    const EdgeInsets.all(16),

                child: Column(
                  children: [

                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .spaceAround,

                      children: [

                        buildStatItem(
                          "Total",
                          totalTasks
                              .toString(),
                        ),

                        buildStatItem(
                          "Completed",
                          completedTasks
                              .toString(),
                        ),

                        buildStatItem(
                          "Pending",
                          pendingTasks
                              .toString(),
                        ),
                      ],
                    ),

                    const SizedBox(
                        height: 20),

                    LinearProgressIndicator(
                      value: progress,

                      minHeight: 10,

                      borderRadius:
                          BorderRadius
                              .circular(
                        10,
                      ),

                      backgroundColor:
                          Colors.grey[
                              300],

                      valueColor:
                          const AlwaysStoppedAnimation(
                        Color(
                          0xFF8C13AA,
                        ),
                      ),
                    ),

                    const SizedBox(
                        height: 10),

                    Text(
                      "${(progress * 100).toInt()}% Completed",
                    ),
                  ],
                ),
              ),
            ),
          ),

          Row(
            mainAxisAlignment:
                MainAxisAlignment
                    .spaceEvenly,

            children: [

              buildFilterButton("All"),

              buildFilterButton(
                  "Pending"),

              buildFilterButton(
                  "Completed"),
            ],
          ),

          const SizedBox(height: 10),

          Expanded(

            child:
                filteredTasks.isEmpty

                    ? const Center(
                        child: Text(
                          "No tasks found",

                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      )

                    : ListView.builder(

                        itemCount:
                            filteredTasks
                                .length,

                        itemBuilder:
                            (context,
                                index) {

                          return GestureDetector(

                            onTap: () {

                              Navigator.push(

                                context,

                                MaterialPageRoute(

                                  builder:
                                      (context) =>
                                          TaskDetailScreen(
                                    task:
                                        filteredTasks[
                                            index],
                                  ),
                                ),
                              ).then((_) {

                                setState(() {});
                              });
                            },

                            child: TaskCard(
                              task:
                                  filteredTasks[
                                      index],
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),

      floatingActionButton:
          FloatingActionButton(

        backgroundColor:
            const Color(0xFF8C13AA),

        onPressed: () {
          showAddTaskBottomSheet();
        },

        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildFilterButton(
      String filterName) {

    bool isSelected =
        currentFilter == filterName;

    return ElevatedButton(

      style:
          ElevatedButton.styleFrom(

        backgroundColor: isSelected
            ? const Color(0xFF8C13AA)
            : Colors.grey[300],

        foregroundColor: isSelected
            ? Colors.white
            : Colors.black,
      ),

      onPressed: () {

        setState(() {

          currentFilter = filterName;
        });
      },

      child: Text(filterName),
    );
  }

  Widget buildStatItem(
    String title,
    String value,
  ) {

    return Column(
      children: [

        Text(
          value,

          style: const TextStyle(
            fontSize: 22,
            fontWeight:
                FontWeight.bold,
            color: Color(0xFF8C13AA),
          ),
        ),

        const SizedBox(height: 5),

        Text(
          title,

          style: const TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  void showSearchDialog() {

    showDialog(
      context: context,

      builder: (context) {

        return AlertDialog(

          title:
              const Text("Search Tasks"),

          content: TextField(

            controller: searchController,

            decoration:
                const InputDecoration(
              hintText:
                  "Enter task title",
            ),

            onChanged: (value) {

              setState(() {});
            },
          ),

          actions: [

            TextButton(

              onPressed: () {

                searchController
                    .clear();

                setState(() {});

                Navigator.pop(context);
              },

              child:
                  const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  void showClearAllDialog() {

    showDialog(
      context: context,

      builder: (context) {

        return AlertDialog(

          title:
              const Text("Clear All Tasks"),

          content: const Text(
            "Are you sure you want to delete all tasks?",
          ),

          actions: [

            TextButton(

              onPressed: () {

                Navigator.pop(context);
              },

              child:
                  const Text("Cancel"),
            ),

            ElevatedButton(

              style:
                  ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.red,
              ),

              onPressed: () {

                setState(() {

                  tasks.clear();
                });

                Navigator.pop(context);
              },

              child:
                  const Text("Delete"),
            ),
          ],
        );
      },
    );
  }

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
                MediaQuery.of(context)
                        .viewInsets
                        .bottom +
                    20,
          ),

          child:
              SingleChildScrollView(

            child: Column(
              mainAxisSize:
                  MainAxisSize.min,

              children: [

                const Text(
                  "Add New Task",

                  style: TextStyle(
                    fontSize: 22,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(
                    height: 20),

                TextField(
                  controller:
                      titleController,

                  decoration:
                      const InputDecoration(
                    labelText:
                        "Task Title",

                    border:
                        OutlineInputBorder(),
                  ),
                ),

                const SizedBox(
                    height: 15),

                TextField(
                  controller:
                      descriptionController,

                  maxLines: 3,

                  decoration:
                      const InputDecoration(
                    labelText:
                        "Description",

                    border:
                        OutlineInputBorder(),
                  ),
                ),

                const SizedBox(
                    height: 15),

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
                      selectedCategory =
                          value!;
                    });
                  },

                  decoration:
                      const InputDecoration(
                    labelText:
                        "Category",

                    border:
                        OutlineInputBorder(),
                  ),
                ),

                const SizedBox(
                    height: 15),

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
                      selectedPriority =
                          value!;
                    });
                  },

                  decoration:
                      const InputDecoration(
                    labelText:
                        "Priority",

                    border:
                        OutlineInputBorder(),
                  ),
                ),

                const SizedBox(
                    height: 15),

                ElevatedButton.icon(

                  onPressed: () async {

                    DateTime? pickedDate =
                        await showDatePicker(

                      context: context,

                      firstDate:
                          DateTime.now(),

                      lastDate:
                          DateTime(2030),

                      initialDate:
                          selectedDate,
                    );

                    if (pickedDate !=
                        null) {

                      setState(() {

                        selectedDate =
                            pickedDate;
                      });
                    }
                  },

                  icon: const Icon(
                    Icons.calendar_month,
                  ),

                  label: Text(
                    "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                  ),
                ),

                const SizedBox(
                    height: 25),

                SizedBox(
                  width: double.infinity,

                  child: ElevatedButton(

                    onPressed: () {
                      if (titleController
                              .text
                              .isEmpty ||
                          descriptionController
                              .text
                              .isEmpty) {

                        ScaffoldMessenger.of(
                                context)
                            .showSnackBar(

                          const SnackBar(
                            content: Text(
                              "Please fill all fields",
                            ),
                          ),
                        );

                        return;
                      }

                      setState(() {

                        tasks.add(
                          Task(
                            title:
                                titleController
                                    .text,

                            description:
                                descriptionController
                                    .text,

                            category:
                                selectedCategory,

                            priority:
                                selectedPriority,

                            dueDate:
                                selectedDate,
                          ),
                        );
                      });
                      
                      titleController.clear();

                      descriptionController
                          .clear();

                      Navigator.pop(
                          context);
                    },

                    child:
                        const Text("Add Task"),
                  ),
                ),

                const SizedBox(
                    height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}