import 'base_user.dart';

class NewUser extends BaseUser {
  String image;
  String name;

  NewUser({
    required this.image,
    required this.name,
    required super.phoneNumber,
    required super.password
  });


  factory NewUser.fromJson(Map<String, dynamic> json) {
    return NewUser(
        image: json['image'],
        name: json['name'],
        phoneNumber: json['phoneNumber'],
        password: json['password'],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'name': name,
      'phoneNumber': phoneNumber,
      'password': password,
    };
  }
}