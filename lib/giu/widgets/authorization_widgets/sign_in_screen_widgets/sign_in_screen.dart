import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:keyboard_shop/core/models/current_user_model.dart';
import 'package:keyboard_shop/data/controllers/database_controller.dart';
import 'package:keyboard_shop/data/model_objects/user/new_user.dart';
import 'package:keyboard_shop/giu/widgets/authorization_widgets/sign_up_screen_widgets/sign_up_screen.dart';
import 'package:keyboard_shop/giu/widgets/main_screen_widgets/catalog/listview_item.dart';
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
            Expanded(
                flex: 5,
                child: Container(
                  alignment: Alignment.center,
                  child: const Text(
                    "Log In",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                    textDirection: TextDirection.ltr,
                  ),
                )
            ),
            Expanded(
                flex: 15,
                child: Container(
                  alignment: Alignment.topCenter,
                  child: CircleAvatar(
                    backgroundColor: Colors.black54,
                    radius: 100,
                    child: SvgPicture.asset('assets/images/default_male_avatar_2.svg'),
                  )
                )
            ),
            Expanded(
              flex: 9,
              child: getTextFormFieldPhoneNumberAndPassword(
                context,
                _inputPhoneNumberDataController,
                _inputPasswordDataController,
              ),
            ),
            Expanded(
                flex: 7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () async {
                        if(_inputPhoneNumberDataController.value.text.isNotEmpty
                            && _inputPasswordDataController.value.text.isNotEmpty
                            && _formKey.currentState!.validate()) {
                          Map<int, NewUser> checkUserNameOrPhoneNumberInDB =
                            await isUserWithThisNameOrPhoneNumberAlreadyExists(
                            _inputPasswordDataController.value.text,
                            '+7 ${_inputPhoneNumberDataController.value.text}',
                          );
                          if(checkUserNameOrPhoneNumberInDB.keys.contains(0)) {
                            if(context.mounted) {
                              context.read<CurrentUserModel>().setCurrentUserAndSharedPreferencesData(
                                true,
                                NewUser(
                                    name: checkUserNameOrPhoneNumberInDB[0]!.name,
                                    phoneNumber: checkUserNameOrPhoneNumberInDB[0]!.phoneNumber,
                                    password: checkUserNameOrPhoneNumberInDB[0]!.password
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                  .removeCurrentSnackBar();
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                  getSnackBar('Successfully'));
                              Navigator.pushNamedAndRemoveUntil(context, 'main', (route) => false);                            }
                          } else if(checkUserNameOrPhoneNumberInDB.keys.contains(1)) {
                            if(context.mounted) {
                              ScaffoldMessenger.of(context)
                                  .removeCurrentSnackBar();
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                  getSnackBar('Incorrect password'));
                            }
                          } else if(checkUserNameOrPhoneNumberInDB.keys.contains(2)) {
                            if(context.mounted) {
                              ScaffoldMessenger.of(context)
                                  .removeCurrentSnackBar();
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                  getSnackBar('Incorrect phone number'));
                            }
                          }
                        } else {
                          ScaffoldMessenger.of(context)
                              .removeCurrentSnackBar();
                          ScaffoldMessenger.of(context)
                              .showSnackBar(
                              getSnackBar('Enter valid data'));
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
                )
            )
          ],
        ),
      )
    );
  }
}


Future<Map<int, NewUser>> isUserWithThisNameOrPhoneNumberAlreadyExists(String password, String phoneNumber) async {
  Map<int, NewUser> isUserWithThisNameOrPhoneNumberAlreadyExists = {};
  List<NewUser> list = await DatabaseController().isDBContainUserWithThisPasswordOrPhoneNumber(password, phoneNumber);
  for(NewUser element in list) {
    if(element.phoneNumber == phoneNumber && element.password == password) {
      isUserWithThisNameOrPhoneNumberAlreadyExists[0] = element;
      return isUserWithThisNameOrPhoneNumberAlreadyExists;
    }
    if(element.phoneNumber == phoneNumber && element.password != password) {
      isUserWithThisNameOrPhoneNumberAlreadyExists[1] = element;
      return isUserWithThisNameOrPhoneNumberAlreadyExists;
    }
    if(element.phoneNumber != phoneNumber && element.password == password) {
      isUserWithThisNameOrPhoneNumberAlreadyExists[2] = element;
      return isUserWithThisNameOrPhoneNumberAlreadyExists;
    }
  }
  return isUserWithThisNameOrPhoneNumberAlreadyExists;
}