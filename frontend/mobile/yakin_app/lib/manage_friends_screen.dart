import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ManageFriendsScreen extends StatefulWidget {
  const ManageFriendsScreen({super.key});

  @override
  State<ManageFriendsScreen> createState() => _ManageFriendsScreenState();
}

class _ManageFriendsScreenState extends State<ManageFriendsScreen> {
  String? studentNumber;
  List<Map<String, dynamic>> friends = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStudentNumberAndFriends();
  }

  Future<void> _loadStudentNumberAndFriends() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    studentNumber = prefs.getString('studentNumber');

    if (studentNumber != null) {
      try {
        QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(studentNumber)
            .collection('friends')
            .get();

        setState(() {
          friends = snapshot.docs.map((doc) {
            return doc.data() as Map<String, dynamic>;
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

  Future<void> _addFriend() async {
    String friendStudentNumber = '';
    String friendPhoneNumber = '';
    final parentContext = context;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Friend'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Friend\'s Student Number',
                  ),
                  onChanged: (value) {
                    friendStudentNumber = value.trim();
                  },
                ),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Friend\'s Phone Number',
                  ),
                  onChanged: (value) {
                    friendPhoneNumber = value.trim();
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();

                if (friendStudentNumber.isEmpty || friendPhoneNumber.isEmpty) {
                  ScaffoldMessenger.of(parentContext).showSnackBar(
                    const SnackBar(content: Text('Please enter both values.')),
                  );
                  return;
                }

                QuerySnapshot userSnapshot = await FirebaseFirestore.instance
                    .collection('users')
                    .where('studentNumber', isEqualTo: friendStudentNumber)
                    .where('phone', isEqualTo: friendPhoneNumber)
                    .get();

                if (userSnapshot.docs.isNotEmpty) {
                  var friendData =
                      userSnapshot.docs.first.data() as Map<String, dynamic>;
                  String foundStudentNumber = friendData['studentNumber'] ?? '';

                  bool alreadyFriend = friends.any((friend) =>
                      friend['studentNumber'] == foundStudentNumber);

                  if (alreadyFriend) {
                    ScaffoldMessenger.of(parentContext).showSnackBar(
                      const SnackBar(
                          content: Text('This user is already your friend.')),
                    );
                    return;
                  }

                  if (foundStudentNumber == studentNumber) {
                    ScaffoldMessenger.of(parentContext).showSnackBar(
                      const SnackBar(
                          content:
                              Text('You cannot add yourself as a friend.')),
                    );
                    return;
                  }

                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(studentNumber)
                      .collection('friends')
                      .doc(foundStudentNumber)
                      .set({
                    'studentNumber': foundStudentNumber,
                    'name': friendData['name'] ?? '',
                    'surname': friendData['surname'] ?? '',
                    'phone': friendData['phone'] ?? '',
                    'email': friendData['email'] ?? '',
                  });

                  setState(() {
                    friends.add({
                      'studentNumber': foundStudentNumber,
                      'name': friendData['name'] ?? '',
                      'surname': friendData['surname'] ?? '',
                      'phone': friendData['phone'] ?? '',
                      'email': friendData['email'] ?? '',
                    });
                  });

                  ScaffoldMessenger.of(parentContext).showSnackBar(
                    const SnackBar(content: Text('Friend added successfully.')),
                  );
                } else {
                  ScaffoldMessenger.of(parentContext).showSnackBar(
                    const SnackBar(content: Text('User not found.')),
                  );
                }
              },
              child: const Text('Add'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _removeFriend(String friendStudentNumber) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(studentNumber)
          .collection('friends')
          .doc(friendStudentNumber)
          .delete();

      setState(() {
        friends.removeWhere(
            (friend) => friend['studentNumber'] == friendStudentNumber);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Friend removed successfully.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: _addFriend,
                icon: const Icon(Icons.person_add, color: Colors.blue),
                label: const Text(
                  'Add Friend',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: friends.isEmpty
                  ? const Center(
                      child: Text(
                        'You have no friends yet.',
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        headingRowColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.blueAccent.withOpacity(0.1),
                        ),
                        columns: const [
                          DataColumn(
                              label: Text('Name',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Student Number',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Process',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                        ],
                        rows: friends.map((friend) {
                          return DataRow(cells: [
                            DataCell(Text(friend['name'] as String)),
                            DataCell(Text(friend['studentNumber'] as String)),
                            DataCell(
                              ElevatedButton(
                                onPressed: () {
                                  _removeFriend(
                                      friend['studentNumber'] as String);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.redAccent,
                                ),
                                child: const Text(
                                  "Remove",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ]);
                        }).toList(),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
