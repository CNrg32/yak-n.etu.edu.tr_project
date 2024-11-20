import 'package:flutter/material.dart';

class ManageSyllabusScreen extends StatelessWidget {
  const ManageSyllabusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Example data for lessons
    final daysOfWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
    final lessons = List.generate(
      5, // Number of time slots
      (rowIndex) => List.generate(
        7, // Number of days in a week
        (dayIndex) => "Lesson Name",
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
              "Manage Syllabus",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // Handle Remove Lesson
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                  ),
                  icon: const Icon(Icons.remove_circle),
                  label: const Text("Remove Lesson"),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: () {
                    // Handle Add Lesson
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  icon: const Icon(Icons.add_circle),
                  label: const Text("Add Lesson"),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Syllabus Table
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Table(
                    border: TableBorder.symmetric(
                      inside: const BorderSide(width: 0.5, color: Colors.grey),
                    ),
                    children: [
                      // Table header (days of the week)
                      TableRow(
                        decoration: const BoxDecoration(color: Colors.blueAccent),
                        children: daysOfWeek
                            .map(
                              (day) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  day,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      // Table content (lessons)
                      ...lessons.map((lessonRow) {
                        return TableRow(
                          children: lessonRow.map((lesson) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "10:00", // Example time slots
                                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      lesson, // Display lesson name
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      }).toList(),
                    ],
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
