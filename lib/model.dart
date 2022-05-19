class Users {
  final String name;
  final String id;
  final String description;

  const Users({
    required this.name,
    required this.id,
    required this.description,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      name: json['name'],
      id: json['id'],
      description: json['description'],
    );
  }
}
