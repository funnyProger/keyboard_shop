import 'package:keyboard_shop/data/model_objects/database/database_entity.dart';

import 'base_user.dart';

class NewUser extends DbEntity implements BaseUser {
  String name;
  @override
  String password;
  @override
  String phoneNumber;

  NewUser({
    required this.name,
    required this.phoneNumber,
    required this.password
  });


  factory NewUser.fromJson(Map<String, dynamic> json) {
    return NewUser(
        name: json['name'],
        phoneNumber: json['phoneNumber'],
        password: json['password'],
    );
  }


  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'password': password,
    };
  }
}