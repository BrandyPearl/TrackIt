import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meet Me"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

          
            const CircleAvatar(
              radius: 55,
              backgroundColor: Color(0xFF8C13AA),

              child: Text(
                "NH",
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              "Ngala Hope Gikeh",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 8),
            const Text(
              "LMUI250890",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),

            const SizedBox(height: 8),
            const Text(
              "Software Engineering",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 30),

            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),

              child: Padding(
                padding: const EdgeInsets.all(20),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Row(
                      children: const [
                        Icon(
                          Icons.person,
                          color: Color(0xFF8C13AA),
                        ),

                        SizedBox(width: 10),

                        Text(
                          "About Me",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 15),

                    Text(
                      "I am a software engineering student, trying to find my place in the tech industry. "
                      "I wouldn't say I enjoy solving real world problems, but I do enjoy the process of learning and improving my skills. "
                      "My goal is to become better one day at a time, and hopefully make a positive impact in the world through technology.",
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            Card(
              elevation: 4,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),

              child: Padding(
                padding: const EdgeInsets.all(20),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Row(
                      children: const [
                        Icon(
                          Icons.flag,
                          color: Color(0xFF8C13AA),
                        ),

                        SizedBox(width: 10),

                        Text(
                          "Semester Goals",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20),

                    buildGoalTile(
                      Icons.check_circle,
                      "Master Flutter mobile development",
                    ),

                    buildGoalTile(
                      Icons.check_circle,
                      "Improve problem-solving skills",
                    ),

                    buildGoalTile(
                      Icons.check_circle,
                      "Build a strong software portfolio",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget buildGoalTile(IconData icon, String goal) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),

      child: Row(
        children: [

          Icon(
            icon,
            color: const Color(0xFF8C13AA),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Text(
              goal,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}