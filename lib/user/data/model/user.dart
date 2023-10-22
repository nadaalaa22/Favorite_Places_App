class User {
  final String name, email, password;

  User({required this.name, required this.email, required this.password});

  Map toMap() => {'name': name, 'email': email, 'password': password};

  factory User.fromMap(Map map) =>
      User(name: map['name'], email: map['email'], password: map['password']);
}
