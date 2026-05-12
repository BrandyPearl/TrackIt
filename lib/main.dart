import 'package:flutter/material.dart';
import 'package:trackit/screens/profile_screen.dart';
import 'screens/task_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Task Manager',

      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,

        colorScheme: const ColorScheme.light(
          primary: Color(0xFF8C13AA),
          secondary: Color(0xFFCBB1C8),
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF8C13AA),
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
      ),

      // Home Screen
      home: const TaskListScreen(),
    );
  }
}