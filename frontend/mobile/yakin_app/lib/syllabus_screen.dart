import 'package:flutter/material.dart';

class SyllabusScreen extends StatelessWidget {
  const SyllabusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Days of the week
    final daysOfWeek = [
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
      "Sunday"
    ];

    // Example lesson times (5 lessons per day)
    final lessonTimes = [
      '08:00 - 08:45',
      '08:55 - 09:40',
      '09:50 - 10:35',
      '10:45 - 11:30',
      '11:40 - 12:25',
    ];

    // Example lessons data (5 lessons per day)
    final lessons = List.generate(
      5, // Number of lessons per day
      (rowIndex) => List.generate(
        7, // Number of days in a week
        (dayIndex) =>
            "Lesson ${(rowIndex + 1) * (dayIndex + 1)}", // Example lesson names
      ),
    );

    // Define DataColumns for days of the week with consistent padding and alignment
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

    // Define DataRows for each lesson time slot
    final dataRows = List<DataRow>.generate(
      lessons.length, // Number of lessons per day
      (lessonIndex) => DataRow(
        cells: List<DataCell>.generate(
          daysOfWeek.length,
          (dayIndex) => DataCell(
            Container(
              constraints: const BoxConstraints(minHeight: 80),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    lessons[lessonIndex][dayIndex],
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    lessonTimes[lessonIndex],
                    style:
                        const TextStyle(fontSize: 12, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("EduConnect"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Syllabus",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal, // Enable horizontal scrolling
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical, // Enable vertical scrolling
                  child: DataTable(
                    columnSpacing: 30, // Remove default column spacing
                    headingRowHeight: 80, // Set consistent header row height
                    dataRowHeight: 80, // Set consistent data row height
                    headingRowColor: MaterialStateProperty.resolveWith(
                      (states) => Colors.blueAccent.withOpacity(0.1),
                    ),
                    columns: dataColumns,
                    rows: dataRows,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
