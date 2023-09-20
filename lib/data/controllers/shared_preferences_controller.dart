import 'package:keyboard_shop/data/get_data/shared_preferences/shared_preferences_data.dart';
import 'package:keyboard_shop/data/model_objects/user/new_user.dart';

abstract class SharedPreferencesControllerInterface {
  setIsLoggedInData(bool isLoggedIn, NewUser newUser);
  getIsLoggedInData();
  getCurrentUserData();
}


class SharedPreferencesController {
  final SharedPreferencesControllerInterface _implementationObject = SharedPreferencesData();

  void saveNewIsLoggedInData(bool isLoggedIn, NewUser newUser) {
    _implementationObject.setIsLoggedInData(isLoggedIn, newUser);
  }


  Future<bool> readIsLoggedInData() async {
    return _implementationObject.getIsLoggedInData();
  }


  Future<NewUser> readCurrentUserDataFromSharedPreferences() async {
    return _implementationObject.getCurrentUserData();
  }
}