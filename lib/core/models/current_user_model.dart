import 'package:flutter/material.dart';
import 'package:keyboard_shop/data/controllers/shared_preferences_controller.dart';
import 'package:keyboard_shop/data/model_objects/user/new_user.dart';

class CurrentUserModel extends ChangeNotifier {
  final SharedPreferencesController _controller = SharedPreferencesController();

  bool _isUserLogged = false;

  final _currentUser = NewUser(
      image: 'assets/images/default_female_avatar_1.svg',
      name: 'User',
      phoneNumber: '^.^',
      password: 'T_T'
  );


  setCurrentUserAndSharedPreferencesData(bool isUserLogged, NewUser newUser) {
    _isUserLogged = isUserLogged;
    _currentUser.image = newUser.image;
    _currentUser.name = newUser.name;
    _currentUser.phoneNumber = newUser.phoneNumber;
    _currentUser.password = newUser.password;

    _controller.saveNewIsLoggedInData(isUserLogged, newUser);
    notifyListeners();
  }


  bool isCurrentUserLoggedIn() {
    return _isUserLogged;
  }


  String getCurrentUserImage() {
    return _currentUser.image;
  }


  String getCurrentUserName() {
    return _currentUser.name;
  }


  String getCurrentUserPhoneNumber() {
    return _currentUser.phoneNumber;
  }


  String getCurrentUserPassword() {
    return _currentUser.password;
  }

}