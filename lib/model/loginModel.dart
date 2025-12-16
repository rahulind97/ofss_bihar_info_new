import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
  String? mobileNumber;
  String? password;
  String? type;

  Login({required this.mobileNumber, required this.password, required this.type});

  Login.fromJson(Map<String, dynamic> json) {
    mobileNumber = json['mobileNumber'];
    password = json['password'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    return {
      'mobileNumber': mobileNumber,
      'password': password,
      'type': type,
    };
  }
}
