class User {
  final int? id;
  final String username;
  final String last_name;
  final String first_name;
  final String password;

  User(
      {this.id,
      required this.username,
      required this.last_name,
      required this.first_name,
      required this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      last_name: json['last_name'],
      first_name: json['first_name'],
      username: json['username'],
      password: json['password'],
    );
  }

  factory User.fromJsonReceived(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      last_name: json['last_name'],
      first_name: json['first_name'],
      username: json['username'],
      password: json['password'],
    );
  }
}
