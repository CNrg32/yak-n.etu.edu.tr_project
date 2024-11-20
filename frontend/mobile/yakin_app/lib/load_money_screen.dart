import 'package:flutter/material.dart';

class LoadMoneyScreen extends StatelessWidget {
  const LoadMoneyScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              "Load Money to Card",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Center(
              child: Column(
                children: [
                  // Balance Circular Chart
                  Container(
                    height: 200,
                    width: 200,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircularProgressIndicator(
                          value: 0.7, // 70% filled
                          strokeWidth: 50,
                          backgroundColor: Colors.grey[300],
                          color: Colors.blueAccent,
                        ),
                        const Text(
                          "1000₺",
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Total Balance",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                  const Text(
                    "Jan, 30 Friday 2024 02:15",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  // Buttons
                  ElevatedButton(
                    onPressed: () {
                      // Handle Add Money Action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    ),
                    child: const Text("Add Money"),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to Payment History Screen
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[400],
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    ),
                    child: const Text("Payment History"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
