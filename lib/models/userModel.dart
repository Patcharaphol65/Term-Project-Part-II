// // import 'package:program_3/models/users.dart';

// class Configure {
//   static const server = "192.168.0.104:3000";
//   // static Users login = Users();
// }

import 'dart:convert';

User UserFromJson(String str) => User.fromJson(json.decode(str));

String UserToJson(User data) => json.encode(data.toJson());

class User {
    String username;
    String fullname;
    String password;

    User({
        required this.username,
        required this.fullname,
        required this.password,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["username"],
        fullname: json["fullname"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "fullname": fullname,
        "password": password,
    };

    static User? userLogin;
}
