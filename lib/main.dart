import 'package:flutter/material.dart';

import 'screens/profile_screen.dart';
import 'screens/task_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  int currentIndex = 1;

  final List<Widget> screens = [

    const TaskListScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      title: "Task Manager",

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

      home: Scaffold(

        body: IndexedStack(
          index: currentIndex,
          children: screens,
        ),

        bottomNavigationBar: BottomNavigationBar(

          currentIndex: currentIndex,

          selectedItemColor:
              const Color(0xFF8C13AA),

          onTap: (index) {

            setState(() {
              currentIndex = index;
            });
          },

          items: const [

            BottomNavigationBarItem(
              icon: Icon(Icons.task),
              label: "Tasks",
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}