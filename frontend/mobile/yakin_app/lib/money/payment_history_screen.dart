import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentHistoryScreen extends StatefulWidget {
  const PaymentHistoryScreen({super.key});

  @override
  State<PaymentHistoryScreen> createState() => _PaymentHistoryScreenState();
}

class _PaymentHistoryScreenState extends State<PaymentHistoryScreen> {
  String? studentNumber;
  bool isLoading = true;
  List<Map<String, dynamic>> transactions = [];

  @override
  void initState() {
    super.initState();
    _loadStudentNumberAndTransactions();
  }

  Future<void> _loadStudentNumberAndTransactions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    studentNumber = prefs.getString('studentNumber');

    if (studentNumber != null) {
      try {
        QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(studentNumber)
            .collection('payment_history')
            .orderBy('date', descending: true)
            .get();

        setState(() {
          transactions = snapshot.docs.map((doc) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            data['date'] = (data['date'] as Timestamp).toDate();
            return data;
          }).toList();
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
    } else {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Öğrenci numarası bulunamadı.')),
      );
    }
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
        title: const Text('Payment History'),
      ),
      body: transactions.isEmpty
          ? const Center(
              child: Text(
                'No transactions found.',
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                var transaction = transactions[index];
                DateTime date = transaction['date'];
                String formattedDate =
                    DateFormat('dd/MM/yyyy HH:mm').format(date);
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: Icon(
                      Icons.credit_card,
                      color: Colors.blueAccent,
                    ),
                    title: Text('Amount: ${transaction['amount']}₺'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Card: ${transaction['cardNumber']}'),
                        Text('Date: $formattedDate'),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
