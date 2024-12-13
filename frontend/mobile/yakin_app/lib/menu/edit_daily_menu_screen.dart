import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import 'daily_menu_screen.dart'; // MenuItem modelini kullanmak için

class EditDailyMenuScreen extends StatefulWidget {
  final DateTime selectedDate;
  final List<MenuItem>? currentMenu;

  const EditDailyMenuScreen({
    super.key,
    required this.selectedDate,
    required this.currentMenu,
  });

  @override
  State<EditDailyMenuScreen> createState() => _EditDailyMenuScreenState();
}

class _EditDailyMenuScreenState extends State<EditDailyMenuScreen> {
  List<MenuItem> menuItems = [];
  List<TextEditingController> typeControllers = [];
  List<TextEditingController> nameControllers = [];
  List<TextEditingController> calorieControllers = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeMenuItems();
  }

  void _initializeMenuItems() {
    if (widget.currentMenu != null) {
      menuItems = List.from(widget.currentMenu!);
    } else {
      menuItems = [];
    }

    // Kontrolörleri oluştur
    for (var item in menuItems) {
      typeControllers.add(TextEditingController(text: item.type));
      nameControllers.add(TextEditingController(text: item.name));
      calorieControllers.add(TextEditingController(text: item.calories.toString()));
    }
  }

  // Yeni menü öğesi eklemek için
  void _addMenuItem() {
    setState(() {
      menuItems.add(MenuItem(type: '', name: '', calories: 0));
      typeControllers.add(TextEditingController());
      nameControllers.add(TextEditingController());
      calorieControllers.add(TextEditingController());
    });
  }

  // Menü öğesini silmek için
  void _removeMenuItem(int index) {
    setState(() {
      menuItems.removeAt(index);
      typeControllers[index].dispose();
      nameControllers[index].dispose();
      calorieControllers[index].dispose();
      typeControllers.removeAt(index);
      nameControllers.removeAt(index);
      calorieControllers.removeAt(index);
    });
  }

  // Menüyü kaydetmek için
  Future<void> _saveMenu() async {
    setState(() {
      isLoading = true;
    });

    // Kontrolörlerden değerleri al
    List<MenuItem> updatedMenuItems = [];
    for (int i = 0; i < menuItems.length; i++) {
      String type = typeControllers[i].text.trim();
      String name = nameControllers[i].text.trim();
      int calories = int.tryParse(calorieControllers[i].text.trim()) ?? 0;

      updatedMenuItems.add(MenuItem(type: type, name: name, calories: calories));
    }

    // Firestore'a kaydet
    String formattedDate = DateFormat('yyyy-MM-dd').format(widget.selectedDate);

    try {
      await FirebaseFirestore.instance
          .collection('daily_menu')
          .doc(formattedDate)
          .set({
        'items': updatedMenuItems.map((item) => item.toMap()).toList(),
      });

      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Menu saved successfully.')),
      );

      Navigator.pop(context); // Geri dön
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving menu: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Daily Menu'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: isLoading ? null : _saveMenu,
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  // Seçilen tarihi göster
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Date: ${DateFormat('dd/MM/yyyy').format(widget.selectedDate)}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Menü öğelerini listeler
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: menuItems.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              TextField(
                                decoration: const InputDecoration(
                                  labelText: 'Dish Type',
                                ),
                                controller: typeControllers[index],
                              ),
                              TextField(
                                decoration: const InputDecoration(
                                  labelText: 'Dish Name',
                                ),
                                controller: nameControllers[index],
                              ),
                              TextField(
                                decoration: const InputDecoration(
                                  labelText: 'Calories',
                                ),
                                keyboardType: TextInputType.number,
                                controller: calorieControllers[index],
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete,
                                    color: Colors.red),
                                onPressed: () {
                                  _removeMenuItem(index);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: _addMenuItem,
                    icon: const Icon(Icons.add),
                    label: const Text('Add Dish'),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
    );
  }
}
