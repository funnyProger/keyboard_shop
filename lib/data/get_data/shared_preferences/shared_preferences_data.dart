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
    sharPref.setString('currentUserImage', newUser.image);
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
  Future<List<String>> getCurrentUserData() async {
    SharedPreferences sharPref = await sharedPreferences;
    List<String> currentUserDataList = [];

    currentUserDataList.add(sharPref.getString('currentUserImage') ?? 'assets/images/default_female_avatar_1.svg');
    currentUserDataList.add(sharPref.getString('currentUserName') ?? 'User');
    currentUserDataList.add(sharPref.getString('currentUserPhoneNumber') ?? '^.^');
    currentUserDataList.add(sharPref.getString('currentUserPassword') ?? 'T_T');

    return currentUserDataList;
  }


}