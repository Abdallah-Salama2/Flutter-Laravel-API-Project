class Category {
  int id;
  String name;
  // the outputs of postman api

  Category({required this.id, required this.name});
  // from json
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(id: json['id'], name: json['name']);
  }
}
