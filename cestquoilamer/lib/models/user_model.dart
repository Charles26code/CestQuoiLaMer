class User {
  String? id;
  String email;
  String password;
  String username;

  User({
    this.id,
    required this.email,
    required this.password,
    required this.username
  });

  User.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        email = json['email'],
        password = json['password'],
        username = json['username'];

  Map<String, dynamic> toJson() {
    if (id != null) {
      return {
        '_id': id,
        'email': email,
        'password': password,
        'username': username,
      };
    } else {
      return {
        'email': email,
        'password': password,
        'username': username,
      };
    }
  }

  String showUser() {
    return "$email\n$password\n$username\n\n";
  }
}
