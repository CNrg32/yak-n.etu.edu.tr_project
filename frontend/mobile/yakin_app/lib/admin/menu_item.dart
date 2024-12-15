class MenuItem {
  final String name;
  final String description;

  MenuItem({required this.name, required this.description});

  factory MenuItem.fromMap(Map<String, dynamic> data) {
    return MenuItem(
      name: data['name'] ?? '',
      description: data['description'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
    };
  }
}
