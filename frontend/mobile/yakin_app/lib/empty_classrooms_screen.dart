// lib/empty_classrooms_screen.dart

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EmptyClassroomsScreen extends StatefulWidget {
  const EmptyClassroomsScreen({super.key});

  @override
  State<EmptyClassroomsScreen> createState() => _EmptyClassroomsScreenState();
}

class _EmptyClassroomsScreenState extends State<EmptyClassroomsScreen> {
  TextEditingController _classroomController = TextEditingController();
  Map<String, Map<String, bool>>? schedule; // Haftanın günleri için
  bool isLoading = false;
  List<String> allClassrooms = [];
  List<String> filteredClassrooms = [];
  String? selectedClassroom;

  // Haftanın günleri
  final List<String> _daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  // Seçili gün için zaman dilimlerini alır
  List<String> _currentDayTimeSlots(String day) {
    return [
      '09:00',
      '10:00',
      '11:00',
      '12:00',
      '13:00',
      '14:00',
      '15:00',
      '16:00',
      '17:00',
    ];
  }

  @override
  void initState() {
    super.initState();
    _loadClassrooms();
    _classroomController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _classroomController.dispose();
    super.dispose();
  }

  Future<void> _loadClassrooms() async {
    setState(() {
      isLoading = true;
    });

    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('empty_classrooms').get();

      setState(() {
        allClassrooms = snapshot.docs.map((doc) => doc.id).toList();
        filteredClassrooms = allClassrooms;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Hata: $e')),
      );
    }
  }

  void _onSearchChanged() {
    String searchText = _classroomController.text.trim().toLowerCase();
    setState(() {
      if (searchText.isEmpty) {
        filteredClassrooms = [];
      } else {
        filteredClassrooms = allClassrooms
            .where((classroom) =>
                classroom.toLowerCase().contains(searchText))
            .toList();
      }
      schedule = null; // Yeni arama yapıldığında zaman çizelgesini sıfırla
    });
  }

  Future<void> _loadSchedule(String classroom) async {
    setState(() {
      isLoading = true;
      schedule = null;
      selectedClassroom = classroom;
    });

    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('empty_classrooms')
          .doc(classroom)
          .get();

      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        Map<String, dynamic> scheduleData = data['schedule'] ?? {};

        // Haftanın her günü için zaman dilimlerini al
        Map<String, Map<String, bool>> loadedSchedule = {};
        for (String day in _daysOfWeek) {
          if (scheduleData.containsKey(day)) {
            loadedSchedule[day] = Map<String, bool>.from(
                scheduleData[day].map((key, value) => MapEntry(key, value as bool)));
          } else {
            // Eğer gün için program yoksa, tüm zaman dilimlerini boş olarak ayarla
            loadedSchedule[day] = {
              '09:00': false,
              '10:00': false,
              '11:00': false,
              '12:00': false,
              '13:00': false,
              '14:00': false,
              '15:00': false,
              '16:00': false,
              '17:00': false,
            };
          }
        }

        setState(() {
          schedule = loadedSchedule;
          isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Program yüklendi')),
        );
      } else {
        setState(() {
          schedule = null;
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sınıf bulunamadı.')),
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Hata: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Sınıf Arama Alanı
            TextField(
              controller: _classroomController,
              decoration: const InputDecoration(
                labelText: 'Search Classroom',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 8),
            // Arama Sonuçları
            if (_classroomController.text.isNotEmpty && schedule == null)
              Expanded(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : filteredClassrooms.isNotEmpty
                        ? ListView.builder(
                            itemCount: filteredClassrooms.length,
                            itemBuilder: (context, index) {
                              String classroom = filteredClassrooms[index];
                              return ListTile(
                                title: Text(classroom),
                                onTap: () {
                                  FocusScope.of(context)
                                      .unfocus(); // Klavyeyi kapat
                                  _classroomController.text = classroom;
                                  filteredClassrooms = [];
                                  _loadSchedule(classroom);
                                },
                              );
                            },
                          )
                        : const Center(
                            child: Text('No classrooms found.'),
                          ),
              ),
            // Seçilen Sınıfın Zaman Çizelgesi
            if (schedule != null && selectedClassroom != null)
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      Text(
                        'Schedule for $selectedClassroom',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      ..._daysOfWeek.map((day) {
                        return ExpansionTile(
                          title: Text(day),
                          children: [
                            ..._currentDayTimeSlots(day).map((time) {
                              bool isEmpty = schedule![day]![time]!;
                              return ListTile(
                                leading: Icon(
                                  isEmpty ? Icons.check_circle : Icons.cancel,
                                  color: isEmpty ? Colors.green : Colors.red,
                                ),
                                title: Text(time),
                                subtitle: Text(
                                  isEmpty ? 'Empty' : 'Occupied',
                                  style: TextStyle(
                                    color: isEmpty ? Colors.green : Colors.red,
                                  ),
                                ),
                              );
                            }).toList(),
                          ],
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ),
            if (schedule == null &&
                _classroomController.text.isEmpty &&
                !isLoading)
              const Expanded(
                child: Center(
                  child: Text('Please search for a classroom.'),
                ),
              ),
          ],
        ),
      ),
    );
  }

}
