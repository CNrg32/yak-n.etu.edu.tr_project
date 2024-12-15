// lib/menu_item.dart

class MenuItem {
  final String name;
  final String description;

  MenuItem({required this.name, required this.description});

  // Firestore'dan veri çekmek için bir factory constructor
  factory MenuItem.fromMap(Map<String, dynamic> data) {
    return MenuItem(
      name: data['name'] ?? '',
      description: data['description'] ?? '',
    );
  }

  // Firestore'a veri kaydetmek için bir method
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
    };
  }
}
