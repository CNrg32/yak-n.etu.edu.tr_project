import 'package:flutter/material.dart';
import 'add_money_screen.dart';
import 'payment_history_screen.dart'; // PaymentHistoryScreen'i içe aktarın
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoadMoneyScreen extends StatefulWidget {
  const LoadMoneyScreen({super.key});

  @override
  State<LoadMoneyScreen> createState() => _LoadMoneyScreenState();
}

class _LoadMoneyScreenState extends State<LoadMoneyScreen> {
  String? studentNumber;
  double balance = 0.0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStudentNumberAndBalance();
  }

  Future<void> _loadStudentNumberAndBalance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    studentNumber = prefs.getString('studentNumber');

    if (studentNumber != null) {
      try {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(studentNumber)
            .get();

        if (userDoc.exists) {
          setState(() {
            balance = userDoc.get('money')?.toDouble() ?? 0.0;
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Kullanıcı bulunamadı.')),
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
    } else {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Öğrenci numarası bulunamadı.')),
      );
    }
  }

  // Add Money ekranından geri döndüğünde bakiyeyi yenilemek için
  void _refreshBalance() {
    setState(() {
      isLoading = true;
    });
    _loadStudentNumberAndBalance();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Load Money'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Load Money to Card",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              // Balance Circular Chart
              SizedBox(
                height: 200,
                width: 200,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(
                      value: (balance % 1000) / 1000, // Örnek değer
                      strokeWidth: 20,
                      backgroundColor: Colors.grey[300],
                      color: Colors.blueAccent,
                    ),
                    Text(
                      "${balance.toStringAsFixed(2)}₺",
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Total Balance",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              const SizedBox(height: 16),
              // Add Money Button
              ElevatedButton(
                onPressed: () async {
                  // AddMoneyScreen'e git ve geri döndüğünde bakiyeyi yenile
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddMoneyScreen(),
                    ),
                  );
                  _refreshBalance();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                ),
                child: const Text("Add Money"),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  // Payment History Screen'e yönlendirin
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PaymentHistoryScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[400],
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                ),
                child: const Text("Payment History"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
