import 'package:keyboard_shop/data/model_objects/database/database_entity.dart';

import 'base_user.dart';

class NewUser extends DbEntity implements BaseUser {
  List<int>? image;
  String name;
  @override
  String password;
  @override
  String phoneNumber;

  NewUser({
    this.image,
    required this.name,
    required this.phoneNumber,
    required this.password
  });


  factory NewUser.fromJson(Map<String, dynamic> json) {
    return NewUser(
      image: json['image'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      password: json['password'],
    );
  }


  @override
  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'name': name,
      'phoneNumber': phoneNumber,
      'password': password,
    };
  }
}