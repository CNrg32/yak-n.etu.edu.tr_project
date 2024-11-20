import 'package:flutter/material.dart';
import 'package:yakin_app/daily_menu_screen.dart';
import 'package:yakin_app/empty_classrooms_screen.dart';
import 'package:yakin_app/load_money_screen.dart';
import 'package:yakin_app/manage_friends_screen.dart';
import 'package:yakin_app/manage_syllabus_screen.dart';
import 'package:yakin_app/syllabus_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EduConnect',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  // List of screens
  final List<Widget> _screens = [
    SyllabusScreen(),
    DailyMenuScreen(),
    LoadMoneyScreen(),
    ManageFriendsScreen(),
    EmptyClassroomsScreen(),
    ManageSyllabusScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex], // Show selected screen
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: "Syllabus",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: "Daily Menu",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money),
            label: "Load Money",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Manage Friends",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.door_back_door),
            label: "Empty Classrooms",
          ),
        ],
      ),
    );
  }
}
