import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ManageClassSchedulesScreen extends StatefulWidget {
  const ManageClassSchedulesScreen({super.key});

  @override
  State<ManageClassSchedulesScreen> createState() =>
      _ManageClassSchedulesScreenState();
}

class _ManageClassSchedulesScreenState
    extends State<ManageClassSchedulesScreen> {
  final TextEditingController _classroomController = TextEditingController();

  final List<String> _daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  String _selectedDay = 'Monday';
  Map<String, bool> _currentDaySchedule = {
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

  bool isLoading = false;
  String? _selectedClassroom;

  @override
  void dispose() {
    _classroomController.dispose();
    super.dispose();
  }

  Future<void> _saveSchedule() async {
    String classroom = _classroomController.text.trim();

    if (classroom.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sınıf numarasını girin')),
      );
      return;
    }

    try {
      DocumentReference classroomDoc = FirebaseFirestore.instance
          .collection('empty_classrooms')
          .doc(classroom);

      DocumentSnapshot docSnapshot = await classroomDoc.get();
      Map<String, dynamic> scheduleData = {};
      if (docSnapshot.exists && docSnapshot.get('schedule') != null) {
        scheduleData = Map<String, dynamic>.from(docSnapshot.get('schedule'));
      }

      scheduleData[_selectedDay] = _currentDaySchedule;

      await classroomDoc.set({
        'schedule': scheduleData,
      }, SetOptions(merge: true));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Program başarıyla kaydedildi')),
      );
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Bir hata oluştu. Lütfen tekrar deneyin.')),
      );
    }
  }

  Future<void> _loadSchedule() async {
    String classroom = _classroomController.text.trim();

    if (classroom.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sınıf numarasını girin')),
      );
      return;
    }

    setState(() {
      isLoading = true;
      _selectedClassroom = classroom;
    });

    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('empty_classrooms')
          .doc(classroom)
          .get();

      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        Map<String, dynamic> scheduleData = data['schedule'] ?? {};

        setState(() {
          _currentDaySchedule = {
            '09:00': scheduleData[_selectedDay]?['09:00'] ?? false,
            '10:00': scheduleData[_selectedDay]?['10:00'] ?? false,
            '11:00': scheduleData[_selectedDay]?['11:00'] ?? false,
            '12:00': scheduleData[_selectedDay]?['12:00'] ?? false,
            '13:00': scheduleData[_selectedDay]?['13:00'] ?? false,
            '14:00': scheduleData[_selectedDay]?['14:00'] ?? false,
            '15:00': scheduleData[_selectedDay]?['15:00'] ?? false,
            '16:00': scheduleData[_selectedDay]?['16:00'] ?? false,
            '17:00': scheduleData[_selectedDay]?['17:00'] ?? false,
          };
          isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Program yüklendi')),
        );
      } else {
        setState(() {
          _currentDaySchedule = {
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
          isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Bu sınıf için program bulunamadı')),
        );
      }
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Hata: $e')),
      );
    }
  }

  void _onDayChanged(String? newDay) {
    if (newDay != null) {
      setState(() {
        _selectedDay = newDay;
      });
      if (_selectedClassroom != null) {
        _loadSchedule();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _classroomController,
              decoration: const InputDecoration(
                labelText: 'Sınıf Numarası',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: _selectedDay,
                  items: _daysOfWeek.map((day) {
                    return DropdownMenuItem(
                      value: day,
                      child: Text(day),
                    );
                  }).toList(),
                  onChanged: _onDayChanged,
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: _loadSchedule,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Yükle'),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: _saveSchedule,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Kaydet'),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            isLoading
                ? const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Expanded(
                    child: ListView(
                      children: _daysOfWeek.map((day) {
                        if (day == _selectedDay && _selectedClassroom != null) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '$day\'s Schedule',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              ..._currentDaySchedule.keys.map((time) {
                                return CheckboxListTile(
                                  title: Text(time),
                                  value: _currentDaySchedule[time],
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _currentDaySchedule[time] =
                                          value ?? false;
                                    });
                                  },
                                );
                              }).toList(),
                            ],
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      }).toList(),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
