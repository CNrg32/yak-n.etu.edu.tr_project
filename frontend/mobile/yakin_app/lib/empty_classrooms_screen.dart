import 'package:flutter/material.dart';

class EmptyClassroomsScreen extends StatelessWidget {
  const EmptyClassroomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Example data for classrooms
    final List<List<bool>> classrooms = List.generate(
      6, // Rows
      (_) => List.generate(5, (index) => index % 2 == 0), // Columns (true: selectable, false: not selectable)
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
              "Empty Classrooms",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: classrooms.map((row) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: row.map((isSelectable) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 120,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: isSelectable ? Colors.green[100] : Colors.red[100],
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: Border.all(
                                    color: isSelectable ? Colors.green : Colors.red,
                                    width: 2,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    isSelectable ? "selectable" : "cannot be selected",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: isSelectable ? Colors.green : Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.blue, width: 1.5),
                ),
                child: const Text(
                  "10:00 Lesson Name",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
