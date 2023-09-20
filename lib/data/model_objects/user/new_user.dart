import 'base_user.dart';

class NewUser extends BaseUser {
  String name;

  NewUser({
    required this.name,
    required super.phoneNumber,
    required super.password
  });


  factory NewUser.fromJson(Map<String, dynamic> json) {
    return NewUser(
        name: json['name'],
        phoneNumber: json['phoneNumber'],
        password: json['password'],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'password': password,
    };
  }
}