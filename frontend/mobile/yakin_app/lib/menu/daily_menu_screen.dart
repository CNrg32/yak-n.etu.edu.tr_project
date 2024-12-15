import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../admin/edit_daily_menu_screen.dart';

class MenuItem {
  final String type;
  final String name;
  final int calories;

  MenuItem({required this.type, required this.name, required this.calories});

  factory MenuItem.fromMap(Map<String, dynamic> data) {
    return MenuItem(
      type: data['type'] ?? '',
      name: data['name'] ?? '',
      calories: data['calories'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'name': name,
      'calories': calories,
    };
  }
}

class DailyMenuScreen extends StatefulWidget {
  const DailyMenuScreen({super.key});

  @override
  _DailyMenuScreenState createState() => _DailyMenuScreenState();
}

class _DailyMenuScreenState extends State<DailyMenuScreen> {
  DateTime _selectedDate = DateTime.now();

  bool isLoading = true;
  List<MenuItem>? currentMenu;

  @override
  void initState() {
    super.initState();
    _fetchMenuForSelectedDate();
  }

  void _onDateChanged(DateTime date) {
    setState(() {
      _selectedDate = date;
      isLoading = true;
    });
    _fetchMenuForSelectedDate();
  }

  Future<void> _fetchMenuForSelectedDate() async {
    String formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate);

    try {
      DocumentSnapshot menuDoc = await FirebaseFirestore.instance
          .collection('daily_menu')
          .doc(formattedDate)
          .get();

      if (menuDoc.exists) {
        List<dynamic> menuData = menuDoc.get('items') as List<dynamic>;

        setState(() {
          currentMenu = menuData.map((item) {
            return MenuItem.fromMap(item as Map<String, dynamic>);
          }).toList();
          isLoading = false;
        });
      } else {
        setState(() {
          currentMenu = null;
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching menu: $e');
      setState(() {
        currentMenu = null;
        isLoading = false;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2023, 1, 1),
      lastDate: DateTime(2025, 12, 31),
    );
    if (picked != null && picked != _selectedDate) {
      _onDateChanged(picked);
    }
  }

  void _goToPreviousDay() {
    DateTime previousDay = _selectedDate.subtract(const Duration(days: 1));
    _onDateChanged(previousDay);
  }

  void _goToNextDay() {
    DateTime nextDay = _selectedDate.add(const Duration(days: 1));
    _onDateChanged(nextDay);
  }

  void _refreshMenu() {
    setState(() {
      isLoading = true;
    });
    _fetchMenuForSelectedDate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: _goToPreviousDay,
                ),
                TextButton(
                  onPressed: () => _selectDate(context),
                  child: Text(
                    DateFormat('dd/MM/yyyy').format(_selectedDate),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      color: Colors.black,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed: _goToNextDay,
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (isLoading)
              const Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            else if (currentMenu != null)
              Expanded(
                child: ListView.builder(
                  itemCount: currentMenu!.length,
                  itemBuilder: (context, index) {
                    MenuItem menuItem = currentMenu![index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 120,
                              height: 40,
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  menuItem.type,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                menuItem.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Text(
                              '${menuItem.calories} kcal',
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            else
              const Expanded(
                child: Center(
                  child: Text(
                    'No menu available for this date',
                    style: TextStyle(fontSize: 16, color: Colors.red),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
