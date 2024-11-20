import 'package:flutter/material.dart';

class ManageFriendsScreen extends StatelessWidget {
  const ManageFriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data for friends
    final List<Map<String, dynamic>> friends = List.generate(
      10,
      (index) => {
        'name': 'Jonas',
        'surname': 'Svensson',
        'age': 15,
        'class': 8,
      },
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
              "Manage Friends",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  headingRowColor: MaterialStateProperty.resolveWith(
                    (states) => Colors.blueAccent.withOpacity(0.1),
                  ),
                  columns: const [
                    DataColumn(label: Text('Name', style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('Surname', style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('Age', style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('Class', style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('Process', style: TextStyle(fontWeight: FontWeight.bold))),
                  ],
                  rows: friends.map((friend) {
                    return DataRow(cells: [
                      DataCell(Text(friend['name'] as String)),
                      DataCell(Text(friend['surname'] as String)),
                      DataCell(Text(friend['age'].toString())), // Convert to String
                      DataCell(Text(friend['class'].toString())), // Convert to String
                      DataCell(
                        ElevatedButton(
                          onPressed: () {
                            // Handle Remove action
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                          ),
                          child: const Text("Remove"),
                        ),
                      ),
                    ]);
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Pagination Controls
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    // Handle previous page
                  },
                ),
                TextButton(
                  onPressed: () {
                    // Handle page change
                  },
                  child: const Text("1"),
                ),
                TextButton(
                  onPressed: () {
                    // Handle page change
                  },
                  child: const Text("2"),
                ),
                TextButton(
                  onPressed: () {
                    // Handle page change
                  },
                  child: const Text("3"),
                ),
                const Text("..."),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    // Handle next page
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
