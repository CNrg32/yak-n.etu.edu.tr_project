import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddMoneyScreen extends StatefulWidget {
  const AddMoneyScreen({super.key});

  @override
  State<AddMoneyScreen> createState() => _AddMoneyScreenState();
}

class _AddMoneyScreenState extends State<AddMoneyScreen>
    with SingleTickerProviderStateMixin {
  // Kart bilgileri için kontrolörler
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _cardHolderNameController =
      TextEditingController(); // Kart sahibi adı için

  // Kartın ön yüzünü veya arka yüzünü göstermek için kontrol
  bool isFront = true;

  // Öğrenci numarası
  String? studentNumber;

  // Son kullanma tarihi önceki uzunluğu
  int _prevExpiryDateLength = 0;

  @override
  void initState() {
    super.initState();
    _loadStudentNumber();
  }

  Future<void> _loadStudentNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    studentNumber = prefs.getString('studentNumber');
  }

  // Kart numarasını formatlamak için
  String get formattedCardNumber {
    String text = _cardNumberController.text.replaceAll(' ', '');
    List<String> parts = [];
    for (int i = 0; i < text.length; i += 4) {
      parts.add(text.substring(i, min(i + 4, text.length)));
    }
    return parts.join(' ');
  }

  // CVV alanına odaklanıldığında kartın arka yüzünü göstermek için
  void _toggleCardFace() {
    setState(() {
      isFront = !isFront;
    });
  }

  // Yükleme işlemini gerçekleştirmek için
 // Yükleme işlemini gerçekleştirmek için
Future<void> _loadMoney() async {
  double amount = double.tryParse(_amountController.text.trim()) ?? 0.0;

  if (amount <= 0) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Lütfen geçerli bir tutar girin.')),
    );
    return;
  }

  if (_cardNumberController.text.trim().isEmpty ||
      _expiryDateController.text.trim().isEmpty ||
      _cvvController.text.trim().isEmpty ||
      _cardHolderNameController.text.trim().isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Lütfen tüm kart bilgilerini girin.')),
    );
    return;
  }

  if (studentNumber == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Öğrenci numarası bulunamadı.')),
    );
    return;
  }

  try {
    DocumentReference userRef =
        FirebaseFirestore.instance.collection('users').doc(studentNumber);

    // Firestore Transaction kullanarak bakiyeyi güncelleyin
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot userSnapshot = await transaction.get(userRef);

      if (!userSnapshot.exists) {
        throw Exception('Kullanıcı bulunamadı.');
      }

      double currentBalance = userSnapshot.get('money')?.toDouble() ?? 0.0;
      double newBalance = currentBalance + amount;

      transaction.update(userRef, {'money': newBalance});
    });

    // Ödeme geçmişine kaydet
    await _saveTransactionToHistory(amount);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Bakiye başarıyla yüklendi.')),
    );

    Navigator.pop(context); // Önceki ekrana dön
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Hata: $e')),
    );
  }
}

// Ödeme geçmişine kaydetmek için fonksiyon
Future<void> _saveTransactionToHistory(double amount) async {
  String cardNumber = _cardNumberController.text.trim();
  String maskedCardNumber = cardNumber.replaceRange(0, cardNumber.length - 4, '*' * (cardNumber.length - 4));

  Map<String, dynamic> transactionData = {
    'cardNumber': maskedCardNumber,
    'amount': amount,
    'date': FieldValue.serverTimestamp(),
  };

  await FirebaseFirestore.instance
      .collection('users')
      .doc(studentNumber)
      .collection('payment_history')
      .add(transactionData);
}

  @override
  Widget build(BuildContext context) {
    // Kartın boyutları
    double cardWidth = MediaQuery.of(context).size.width * 0.8;
    double cardHeight = 200;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Money'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            // Kart Görseli
            GestureDetector(
              onTap: _toggleCardFace,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder:
                    (Widget child, Animation<double> animation) {
                  final rotate =
                      Tween(begin: pi, end: 0.0).animate(animation);
                  return AnimatedBuilder(
                    animation: rotate,
                    child: child,
                    builder: (context, child) {
                      // Kartın yamuk görünmesini engellemek için tilt'i kaldırdık
                      final value = rotate.value;
                      return Transform(
                        transform: Matrix4.rotationY(value),
                        alignment: Alignment.center,
                        child: child,
                      );
                    },
                  );
                },
                child: isFront
                    ? _buildFrontCard(cardWidth, cardHeight)
                    : _buildBackCard(cardWidth, cardHeight),
              ),
            ),
            const SizedBox(height: 16),
            // Kart Bilgileri Giriş Alanları
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                children: [
                  TextField(
                    controller: _cardNumberController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Card Number',
                    ),
                    maxLength: 16,
                    onTap: () {
                      if (!isFront) _toggleCardFace();
                    },
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                  TextField(
                    controller: _expiryDateController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Expiry Date (MM/YY)',
                    ),
                    maxLength: 5,
                    onTap: () {
                      if (!isFront) _toggleCardFace();
                    },
                    onChanged: (value) {
                      // Son kullanma tarihi formatlaması
                      if (value.length == 2 &&
                          _prevExpiryDateLength < value.length) {
                        _expiryDateController.text = '$value/';
                        _expiryDateController.selection =
                            TextSelection.fromPosition(
                          TextPosition(
                              offset: _expiryDateController.text.length),
                        );
                      }
                      _prevExpiryDateLength =
                          _expiryDateController.text.length;
                      setState(() {});
                    },
                  ),
                  TextField(
                    controller: _cvvController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'CVV',
                    ),
                    maxLength: 3,
                    onTap: () {
                      if (isFront) _toggleCardFace();
                    },
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                  TextField(
                    controller: _cardHolderNameController,
                    decoration: const InputDecoration(
                      labelText: 'Cardholder Name',
                    ),
                    onTap: () {
                      if (!isFront) _toggleCardFace();
                    },
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                  TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Amount',
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _loadMoney,
                    child: const Text('Load', style: TextStyle(color: Colors.blue),),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Kartın ön yüzünü oluşturmak için
  Widget _buildFrontCard(double width, double height) {
    return Container(
      key: const ValueKey(true),
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.blueAccent,
      ),
      child: Stack(
        children: [
          // Kart Numarası
          Positioned(
            top: height * 0.4,
            left: 20,
            child: Text(
              formattedCardNumber.isEmpty
                  ? 'XXXX XXXX XXXX XXXX'
                  : formattedCardNumber,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                letterSpacing: 2,
              ),
            ),
          ),
          // Son Kullanma Tarihi
          Positioned(
            bottom: 20,
            left: 20,
            child: Text(
              _expiryDateController.text.isEmpty
                  ? 'MM/YY'
                  : _expiryDateController.text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
          // Kart Sahibinin Adı
          Positioned(
            bottom: 20,
            right: 20,
            child: Text(
              _cardHolderNameController.text.isEmpty
                  ? 'CARDHOLDER NAME'
                  : _cardHolderNameController.text.toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Kartın arka yüzünü oluşturmak için
  Widget _buildBackCard(double width, double height) {
    return Container(
      key: const ValueKey(false),
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.blueGrey,
      ),
      child: Stack(
        children: [
          // Siyah Şerit
          Positioned(
            top: height * 0.1,
            child: Container(
              width: width,
              height: 40,
              color: Colors.black,
            ),
          ),
          // CVV
          Positioned(
            top: height * 0.4,
            right: 20,
            child: Container(
              width: 60,
              height: 30,
              color: Colors.white,
              alignment: Alignment.center,
              child: Text(
                _cvvController.text.isEmpty ? '***' : _cvvController.text,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  letterSpacing: 2,
                ),
              ),
            ),
          ),
          // Kart Sahibinin İmzası (Örnek)
          Positioned(
            bottom: 20,
            left: 20,
            child: const Text(
              'Authorized Signature',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
