import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:keyboard_shop/constants/constants.dart';
import 'package:keyboard_shop/core/models/cart_model.dart';
import 'package:keyboard_shop/core/models/current_user_model.dart';
import 'package:keyboard_shop/core/models/favorites_model.dart';
import 'package:keyboard_shop/data/controllers/database_controller.dart';
import 'package:keyboard_shop/data/model_objects/user/new_user.dart';
import 'package:keyboard_shop/giu/widgets/authorization_widgets/sign_up_screen_widgets/sign_up_screen.dart';
import 'package:keyboard_shop/giu/widgets/main_screen_widgets/catalog/listview_item.dart';
import 'package:keyboard_shop/root/main.dart';
import 'package:provider/provider.dart';

class SignInScreenWidget extends StatefulWidget {
  const SignInScreenWidget({super.key});

  @override
  State<SignInScreenWidget> createState() => SignInScreenWidgetState();
}


class SignInScreenWidgetState extends State<SignInScreenWidget> {
  final _inputPhoneNumberDataController = TextEditingController();
  final _inputPasswordDataController = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  @override
  void dispose() {
    _inputPhoneNumberDataController.dispose();
    _inputPasswordDataController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
              width: 4,
              color: Colors.black
          )
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              height: 85,
              alignment: Alignment.center,
              child: const Text(
                "Log In",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
                textDirection: TextDirection.ltr,
              ),
            ),
            Container(
                height: 200,
                alignment: Alignment.topCenter,
                child: CircleAvatar(
                  backgroundColor: Colors.black54,
                  radius: 100,
                  child: SvgPicture.asset('assets/images/default_male_avatar_2.svg'),
                )
            ),
            Container(
              margin: const EdgeInsets.only(top: 80, bottom: 110),
              child: getTextFormFieldPhoneNumberAndPassword(
                context,
                _inputPhoneNumberDataController,
                _inputPasswordDataController,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 47),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      if(_inputPhoneNumberDataController.value.text.isNotEmpty
                          && _inputPasswordDataController.value.text.isNotEmpty
                          && _formKey.currentState!.validate()) {
                        ({int queryKeyResult, NewUser userDataFromDb}) checkUserNameOrPhoneNumberInDB =
                        await checkEnteredDataInDatabase(
                          context,
                          _inputPasswordDataController.value.text,
                          '+7 ${_inputPhoneNumberDataController.value.text}',
                        );
                        if(checkUserNameOrPhoneNumberInDB.queryKeyResult == Constants.successLogin) {
                          if(context.mounted) {
                            context.read<CurrentUserModel>().setCurrentUserAndSharedPreferencesData(
                              true,
                              NewUser(
                                  image:  checkUserNameOrPhoneNumberInDB.userDataFromDb.image,
                                  name: checkUserNameOrPhoneNumberInDB.userDataFromDb.name,
                                  phoneNumber: checkUserNameOrPhoneNumberInDB.userDataFromDb.phoneNumber,
                                  password: checkUserNameOrPhoneNumberInDB.userDataFromDb.password
                              ),
                            );
                            await initAppData();
                            if(context.mounted) {
                              context.read<CartModel>().updateData();
                              context.read<FavoritesModel>().updateData();
                              showSnackBar(context, 'Successfully');
                              Navigator.pushNamedAndRemoveUntil(context, 'main', (route) => false);
                            }
                          }
                        } else if(checkUserNameOrPhoneNumberInDB.queryKeyResult == Constants.errorLogin) {
                          if(context.mounted) {
                            showSnackBar(context, 'Incorrect phone number or password');
                          }
                        }
                      } else {
                        showSnackBar(context, 'Enter valid data');
                      }
                    },
                    borderRadius: BorderRadius.circular(50),
                    splashColor: Colors.black,
                    child: Container(
                      height: 45,
                      width: 200,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.green,
                      ),
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                        textDirection: TextDirection.ltr,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}


Future<({int queryKeyResult, NewUser userDataFromDb})> checkEnteredDataInDatabase(BuildContext context, String password, String phoneNumber) async {
  ({int queryKeyResult, NewUser userDataFromDb})  databaseQueryResult =
        (queryKeyResult: Constants.errorLogin, userDataFromDb: NewUser(
            name: '', phoneNumber: '', password: ''));

  NewUser? userData =
      await DatabaseController().isDBContainUserWithThisPasswordAndPhoneNumber(password, phoneNumber);

  if(userData != null) {
    databaseQueryResult = (queryKeyResult: Constants.successLogin, userDataFromDb: userData);
  }

  return databaseQueryResult;
}