class Category {
  int id;
  String name;

  Category({required this.id, required this.name});

  factory Category.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      // Handle the case where json is null
      return Category(id: 0, name: '');
    }

    return Category(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }
}
