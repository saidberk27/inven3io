class User {
  late String username;
  late String password;
  late String userID;
  late String mail;

  User({
    required this.username,
    required this.password,
    required this.userID,
    required this.mail,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': ".",
      'userID': userID,
      'mail': mail,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      password: ".",
      userID: json['userID'],
      mail: json['mail'],
    );
  }
}
