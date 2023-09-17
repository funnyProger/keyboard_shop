import 'package:keyboard_shop/data/model_objects/user/base_user.dart';

class ExistsUser extends BaseUser {

  ExistsUser({
    required super.phoneNumber,
    required super.password
  });


  factory ExistsUser.fromJson(Map<String, dynamic> json) {
    return ExistsUser(
      phoneNumber: json['phoneNumber'],
      password: json['password'],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'phoneNumber': phoneNumber,
      'password': password,
    };
  }
}