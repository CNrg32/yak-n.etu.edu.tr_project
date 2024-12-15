// lib/admin_screen.dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yakin_app/admin/admin_menu.dart';
import 'package:yakin_app/admin/manage_class_schedule_screen.dart';
import 'package:yakin_app/first_screens/login_screen.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {


  // Çıkış yapma fonksiyonu
  Future<void> _logout() async {
    // Çıkış yapmadan önce onay isteyelim
    bool? confirmLogout = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Çıkış Yap'),
        content: const Text('Hesabınızdan çıkış yapmak istediğinize emin misiniz?'),
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
      await prefs.setBool('login', false); // Giriş durumunu false yap
      await prefs.remove('studentNumber'); // Öğrenci numarasını sil (isteğe bağlı)

      // LoginScreen'e yönlendir ve önceki sayfaları temizle
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false,
      );
    }
  }

  int _selectedIndex = 0;

  // Ekranlar listesi
  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      const AdminMenu(),
      const ManageClassSchedulesScreen(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar ekleyebilirsiniz
      appBar: AppBar(
        title: const Text('Admin Paneli'),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Günlük Menü',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.class_),
            label: 'Sınıf Programları',
          ),
        ],
      ),
    );
  }
}
