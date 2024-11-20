import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For formatting dates

// Model class for Menu Items
class MenuItem {
  final String type;
  final String name;
  final int calories;

  MenuItem({required this.type, required this.name, required this.calories});
}

class DailyMenuScreen extends StatefulWidget {
  const DailyMenuScreen({super.key});

  @override
  _DailyMenuScreenState createState() => _DailyMenuScreenState();
}

class _DailyMenuScreenState extends State<DailyMenuScreen> {
  DateTime _selectedDate = DateTime.now();

  // Sample menu data with dates as keys in 'yyyy-MM-dd' format
  final Map<String, List<MenuItem>> menuData = {
    '2024-11-20': [
      MenuItem(type: 'Soup', name: 'Tomato Soup', calories: 150),
      MenuItem(type: 'Main Dish 1', name: 'Grilled Chicken', calories: 350),
      MenuItem(type: 'Main Dish 2', name: 'Pasta Alfredo', calories: 400),
      MenuItem(type: 'Dessert', name: 'Chocolate Cake', calories: 250),
    ],
    '2024-11-21': [
      MenuItem(type: 'Soup', name: 'Chicken Noodle Soup', calories: 180),
      MenuItem(type: 'Main Dish 1', name: 'Beef Steak', calories: 500),
      MenuItem(type: 'Main Dish 2', name: 'Baked Salmon', calories: 450),
      MenuItem(type: 'Dessert', name: 'Apple Pie', calories: 300),
    ],
    // Add more dates and menu items as needed
  };

  // Function to open the date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2024, 11, 1),
      lastDate: DateTime(2027, 12, 31),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  // Function to navigate to the previous day
  void _goToPreviousDay() {
    setState(() {
      _selectedDate = _selectedDate.subtract(const Duration(days: 1));
    });
  }

  // Function to navigate to the next day
  void _goToNextDay() {
    setState(() {
      _selectedDate = _selectedDate.add(const Duration(days: 1));
    });
  }

  @override
  Widget build(BuildContext context) {
    // Format the selected date as 'yyyy-MM-dd' for menuData lookup
    String formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate);
    // Get the menu for the selected date
    List<MenuItem>? currentMenu = menuData[formattedDate];

    return Scaffold(
      appBar: AppBar(
        title: const Text("EduConnect"),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              // User account actions
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with date and navigation arrows
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Previous Day Arrow
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: _goToPreviousDay,
                ),
                // Date Display with Date Picker
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
                // Next Day Arrow
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed: _goToNextDay,
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Display the menu items for the selected date
            if (currentMenu != null)
              Expanded(
                child: ListView.builder(
                  itemCount: currentMenu.length,
                  itemBuilder: (context, index) {
                    MenuItem menuItem = currentMenu[index];
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
                            // Dish Type
                            SizedBox(
                              width: 120, // Fixed width for alignment
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
                            // Dish Name
                            Expanded(
                              child: Text(
                                menuItem.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            // Calories
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
      bottomNavigationBar: BottomNavigationBar(
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
            icon: Icon(Icons.group),
            label: "Manage Friends",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.class_),
            label: "Empty Classrooms",
          ),
        ],
        currentIndex: 1, // Set the current screen
        onTap: (index) {
          // Implement navigation based on index
          // Example:
          // if (index == 0) { navigate to SyllabusScreen }
          // if (index == 2) { navigate to ManageFriendsScreen }
          // etc.
        },
      ),
    );
  }
}
