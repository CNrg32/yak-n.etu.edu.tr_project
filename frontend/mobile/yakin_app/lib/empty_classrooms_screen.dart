import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EmptyClassroomsScreen extends StatefulWidget {
  const EmptyClassroomsScreen({super.key});

  @override
  State<EmptyClassroomsScreen> createState() => _EmptyClassroomsScreenState();
}

class _EmptyClassroomsScreenState extends State<EmptyClassroomsScreen> {
  TextEditingController _classroomController = TextEditingController();
  Map<String, bool>? schedule;
  bool isLoading = false;
  List<String> allClassrooms = [];
  List<String> filteredClassrooms = [];
  String? selectedClassroom;

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
        setState(() {
          schedule = Map<String, bool>.from(doc.get('schedule'));
          // Zaman dilimlerini sıralı hale getirelim
          schedule = Map.fromEntries(schedule!.entries.toList()
            ..sort((e1, e2) => e1.key.compareTo(e2.key)));
          isLoading = false;
        });
      } else {
        setState(() {
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
      appBar: AppBar(
        title: const Text('Empty Classrooms'),
      ),
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
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      'Schedule for $selectedClassroom',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: ListView(
                        children: schedule!.entries.map((entry) {
                          String time = entry.key;
                          bool isEmpty = entry.value;
                          return ListTile(
                            leading: Icon(
                              isEmpty ? Icons.check_circle : Icons.cancel,
                              color: isEmpty ? Colors.green : Colors.red,
                            ),
                            title: Text('$time'),
                            subtitle: Text(
                              isEmpty ? 'Empty' : 'Occupied',
                              style: TextStyle(
                                color: isEmpty ? Colors.green : Colors.red,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
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
