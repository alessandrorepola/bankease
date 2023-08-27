class User {
  final String name;
  final String surname;
  final String username;

  User({
    required this.name,
    required this.surname,
    required this.username,
  });

  factory User.fromJson(Map<String, dynamic> data) {
    return User(
      name: data['name'],
      surname: data['surname'],
      username: data['username'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'surname': surname,
      'username': username,
    };
  }
}
