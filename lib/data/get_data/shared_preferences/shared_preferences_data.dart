import 'package:keyboard_shop/data/controllers/shared_preferences_controller.dart';
import 'package:keyboard_shop/data/model_objects/user/new_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesData implements SharedPreferencesControllerInterface {
  SharedPreferences? _sharedPreferences;


  Future<SharedPreferences> get sharedPreferences async {
    if(_sharedPreferences != null) {
      return _sharedPreferences!;
    } else {
      _sharedPreferences = await SharedPreferences.getInstance();
      return _sharedPreferences!;
    }
  }


  @override
  void setIsLoggedInData(bool isLoggedIn, NewUser newUser) async {
    SharedPreferences sharPref = await sharedPreferences;

    sharPref.setBool('isLoggedIn', isLoggedIn);
    sharPref.setString('currentUserName', newUser.name);
    sharPref.setString('currentUserPhoneNumber', newUser.phoneNumber);
    sharPref.setString('currentUserPassword', newUser.password);
  }


  @override
  Future<bool> getIsLoggedInData() async {
    SharedPreferences sharPref = await sharedPreferences;

    bool isLoggedIn = sharPref.getBool('isLoggedIn') ?? false;
    return isLoggedIn;
  }


  @override
  Future<NewUser> getCurrentUserData() async {
    SharedPreferences sharPref = await sharedPreferences;

    return NewUser(
        name: sharPref.getString('currentUserName') ?? '',
        phoneNumber: sharPref.getString('currentUserPhoneNumber') ?? '',
        password: sharPref.getString('currentUserPassword') ?? ''
    );
  }
}