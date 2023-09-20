import 'package:flutter/material.dart';
import 'package:keyboard_shop/data/controllers/shared_preferences_controller.dart';
import 'package:keyboard_shop/data/model_objects/user/new_user.dart';

class CurrentUserModel extends ChangeNotifier {
  final SharedPreferencesController _sherPrefController = SharedPreferencesController();

  bool _isUserLogged = false;

  final _currentUser = NewUser(
      name: 'User',
      phoneNumber: '^.^',
      password: 'T_T'
  );


  void setCurrentUserAndSharedPreferencesData(bool isUserLogged, NewUser newUser) {
    _isUserLogged = isUserLogged;
    _currentUser.name = newUser.name;
    _currentUser.phoneNumber = newUser.phoneNumber;
    _currentUser.password = newUser.password;

    _sherPrefController.saveNewIsLoggedInData(isUserLogged, newUser);
    notifyListeners();
  }


  bool isCurrentUserLoggedIn() {
    return _isUserLogged;
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


  Future<void> initAndCheckSharedPreferencesData() async {
    bool isCurrentUserLoggedInFromSharedPreferences = await _sherPrefController.readIsLoggedInData();
    _isUserLogged = isCurrentUserLoggedInFromSharedPreferences;

    NewUser currentUserFromSherPref = await _sherPrefController.readCurrentUserDataFromSharedPreferences();
    if(currentUserFromSherPref.name != '') {
      _currentUser.name = currentUserFromSherPref.name;
    }
    if(currentUserFromSherPref.phoneNumber != '') {
      _currentUser.phoneNumber = currentUserFromSherPref.phoneNumber;
    }
    if(currentUserFromSherPref.password != '') {
      _currentUser.password = currentUserFromSherPref.password;
    }
    notifyListeners();
  }
}