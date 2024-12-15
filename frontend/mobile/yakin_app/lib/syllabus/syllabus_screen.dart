import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'edit_syllabus_screen.dart'; // Düzenleme ekranını içe aktarın

class SyllabusScreen extends StatefulWidget {
  const SyllabusScreen({super.key});

  @override
  State<SyllabusScreen> createState() => _SyllabusScreenState();
}

class _SyllabusScreenState extends State<SyllabusScreen> {
  String? studentNumber;
  Map<String, dynamic>? syllabusData;
  bool isLoading = true;

  final daysOfWeek = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];

  @override
  void initState() {
    super.initState();
    _loadStudentNumberAndSyllabus();
  }

  Future<void> _loadStudentNumberAndSyllabus() async {
    // SharedPreferences'tan öğrenci numarasını al
    SharedPreferences prefs = await SharedPreferences.getInstance();
    studentNumber = prefs.getString('studentNumber');

    if (studentNumber != null) {
      try {
        // Firestore'dan ders programını al
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(studentNumber)
            .get();

        if (userDoc.exists) {
          setState(() {
            syllabusData =
                userDoc.get('syllabus') as Map<String, dynamic>? ?? {};
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
          });
        }
      } catch (e) {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Ders programını güncelleme sonrasında yeniden yüklemek için
  void _refreshSyllabus() {
    setState(() {
      isLoading = true;
    });
    _loadStudentNumberAndSyllabus();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (syllabusData == null || syllabusData!.isEmpty) {
      return Scaffold(
        body: const Center(
          child: Text(
            'Ders programı bulunamadı.',
            style: TextStyle(fontSize: 18),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.edit),
          backgroundColor: Colors.white,
          foregroundColor: Colors.blue,
          onPressed: () async {
            // Düzenleme ekranına git ve geri döndüğünde ders programını yenile
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const EditSyllabusScreen(),
              ),
            );
            _refreshSyllabus();
          },
        ),
      );
    }

    // En fazla ders sayısını bulmak için
    int maxLessonsPerDay = 0;

    // Günlere göre dersleri hazırlayın
    final lessonsPerDay = <String, List<Map<String, dynamic>>>{};

    for (var day in daysOfWeek) {
      var lessons = syllabusData![day] as List<dynamic>? ?? [];
      lessonsPerDay[day] =
          List<Map<String, dynamic>>.from(lessons.cast<Map<String, dynamic>>());
      if (lessons.length > maxLessonsPerDay) {
        maxLessonsPerDay = lessons.length;
      }
    }

    // DataRows'u oluşturun
    final dataRows = List<DataRow>.generate(
      maxLessonsPerDay,
      (lessonIndex) => DataRow(
        cells: List<DataCell>.generate(
          daysOfWeek.length,
          (dayIndex) {
            var day = daysOfWeek[dayIndex];
            var dayLessons = lessonsPerDay[day] ?? [];
            if (dayLessons.length > lessonIndex) {
              var lesson = dayLessons[lessonIndex];
              return DataCell(
                Container(
                  constraints: const BoxConstraints(minHeight: 80),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        lesson['lessonName'],
                        style: const TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        lesson['time'],
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const DataCell(
                SizedBox.shrink(), // Boş hücre
              );
            }
          },
        ),
      ),
    );

    // DataColumns'u oluşturun
    final dataColumns = daysOfWeek
        .map(
          (day) => DataColumn(
            label: Container(
              padding: const EdgeInsets.all(8.0),
              constraints: const BoxConstraints(minHeight: 80),
              alignment: Alignment.center,
              child: Text(
                day,
                style: const TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        )
        .toList();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal, // Yatay kaydırma
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical, // Dikey kaydırma
            child: DataTable(
              columnSpacing: 30,
              headingRowHeight: 80,
              dataRowHeight: 80,
              headingRowColor: MaterialStateProperty.resolveWith(
                (states) => Colors.blueAccent.withOpacity(0.1),
              ),
              columns: dataColumns,
              rows: dataRows,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.edit),
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue,
        onPressed: () async {
          // Düzenleme ekranına git ve geri döndüğünde ders programını yenile
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const EditSyllabusScreen(),
            ),
          );
          _refreshSyllabus();
        },
      ),
    );
  }
}
