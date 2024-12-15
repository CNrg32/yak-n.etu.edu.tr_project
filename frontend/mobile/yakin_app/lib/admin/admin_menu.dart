import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Tarih formatlama için
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore için
import '../admin/edit_daily_menu_screen.dart'; // Yemek ekleme ekranını içe aktarın

// Model class for Menu Items
class MenuItem2 {
  final String type;
  final String name;
  final int calories;

  MenuItem2({required this.type, required this.name, required this.calories});

  // Firestore'dan veri çekerken kullanmak için bir factory constructor ekleyelim
  factory MenuItem2.fromMap(Map<String, dynamic> data) {
    return MenuItem2(
      type: data['type'] ?? '',
      name: data['name'] ?? '',
      calories: data['calories'] ?? 0,
    );
  }

  // Firestore'a veri kaydederken kullanmak için bir toMap() fonksiyonu ekleyelim
  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'name': name,
      'calories': calories,
    };
  }
}

class AdminMenu extends StatefulWidget {
  const AdminMenu({super.key});

  @override
  _AdminMenuState createState() => _AdminMenuState();
}

class _AdminMenuState extends State<AdminMenu> {
  DateTime _selectedDate = DateTime.now();

  bool isLoading = true;
  List<MenuItem2>? currentMenu;

  @override
  void initState() {
    super.initState();
    _fetchMenuForSelectedDate();
  }

  // Tarih değiştiğinde menüyü yeniden fetch etmek için
  void _onDateChanged(DateTime date) {
    setState(() {
      _selectedDate = date;
      isLoading = true;
    });
    _fetchMenuForSelectedDate();
  }

  // Firestore'dan seçilen tarih için menüyü çeken fonksiyon
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
            return MenuItem2.fromMap(item as Map<String, dynamic>);
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

  // Tarih seçici fonksiyonu
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

  // Önceki güne gitme fonksiyonu
  void _goToPreviousDay() {
    DateTime previousDay = _selectedDate.subtract(const Duration(days: 1));
    _onDateChanged(previousDay);
  }

  // Sonraki güne gitme fonksiyonu
  void _goToNextDay() {
    DateTime nextDay = _selectedDate.add(const Duration(days: 1));
    _onDateChanged(nextDay);
  }

  // Menüdeki değişikliklerden sonra ekranı yenilemek için
  void _refreshMenu() {
    setState(() {
      isLoading = true;
    });
    _fetchMenuForSelectedDate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Menu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tarih ve navigasyon okları
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Önceki gün
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: _goToPreviousDay,
                ),
                // Tarih gösterimi ve tarih seçici
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
                // Sonraki gün
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed: _goToNextDay,
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Menü verilerini göster
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
                    MenuItem2 menuItem = currentMenu![index];
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
                            // Yemek Türü
                            SizedBox(
                              width: 120, // Hizalama için sabit genişlik
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
                            // Yemek Adı
                            Expanded(
                              child: Text(
                                menuItem.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            // Kalori
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
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.edit),
        onPressed: () async {
          // Yemek ekleme ekranına git ve geri döndüğünde menüyü yenile
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditDailyMenuScreen(
                selectedDate: _selectedDate,
                currentMenu: currentMenu,
              ),
            ),
          );
          _refreshMenu();
        },
      ),
    );
  }
}
