import 'package:flutter/material.dart';
import '../syllabus/syllabus_screen.dart';
import '../menu/daily_menu_screen.dart';
import '../money/load_money_screen.dart';
import '../manage_friends_screen.dart';
import '../empty_classrooms_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const SyllabusScreen(),
    const DailyMenuScreen(),
    const LoadMoneyScreen(),
    const ManageFriendsScreen(),
    const EmptyClassroomsScreen(),
  ];

  Future<void> _logout() async {
    bool? confirmLogout = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Çıkış Yap'),
        content:
            const Text('Hesabınızdan çıkış yapmak istediğinize emin misiniz?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('İptal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Çıkış Yap'),
          ),
        ],
      ),
    );

    if (confirmLogout == true) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('login', false);
      await prefs.remove('studentNumber');

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text('EduConnect'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: _screens[_currentIndex],
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
