import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:keyboard_shop/constants/constants.dart';
import 'package:keyboard_shop/core/models/cart_model.dart';
import 'package:keyboard_shop/core/models/current_user_model.dart';
import 'package:keyboard_shop/core/models/favorites_model.dart';
import 'package:keyboard_shop/data/controllers/database_controller.dart';
import 'package:keyboard_shop/data/model_objects/user/new_user.dart';
import 'package:keyboard_shop/giu/widgets/authorization_widgets/sign_in_screen_widgets/sign_in_screen_container.dart';
import 'package:keyboard_shop/giu/widgets/main_screen_widgets/catalog/listview_item.dart';
import 'package:keyboard_shop/root/main.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class SignUpScreenWidget extends StatefulWidget {
  const SignUpScreenWidget({super.key});

  @override
  State<SignUpScreenWidget> createState() => SignUpScreenWidgetState();
}

class SignUpScreenWidgetState extends State<SignUpScreenWidget> {
  final _inputNameDataController = TextEditingController();
  final _inputPhoneNumberDataController = TextEditingController();
  final _inputPasswordDataController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final DatabaseController _databaseController = DatabaseController();


  @override
  void dispose() {
    _inputNameDataController.dispose();
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
                "Registration",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30  ,
                ),
                textDirection: TextDirection.ltr,
              ),
            ),
            Container(
              height: 200,
                alignment: Alignment.center,
                child: InkWell(
                    borderRadius: BorderRadius.circular(100),
                    child: CircleAvatar(
                      backgroundColor: Colors.black54,
                      radius: 100,
                      child: SvgPicture.asset('assets/images/default_male_avatar_1.svg'),
                    )
                )
            ),
            Container(
              padding: const EdgeInsets.only(top: 16, bottom: 30),
              alignment: Alignment.center,
              child: const Text(
                'Add an avatar',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),
                textDirection: TextDirection.ltr,
              ),
            ),
            Container(
              height: 90,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 70, right: 70),
              child: TextFormField(
                keyboardType: TextInputType.text,
                controller: _inputNameDataController,
                validator: (value) {
                  if(value != null && value.contains(' ')) {
                    return 'Invalid name';
                  } else if(value != '' && value!.length < 2) {
                    return 'Name min 2 characters';
                  }
                  return null;
                },
                autovalidateMode: AutovalidateMode.always,
                textAlign: TextAlign.justify,
                cursorOpacityAnimates: true,
                cursorColor: Colors.white,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17
                ),
                decoration:  InputDecoration(
                  labelText: 'Name',
                  floatingLabelAlignment: FloatingLabelAlignment.center,
                  labelStyle: const TextStyle(color: Colors.grey),
                  floatingLabelStyle: MaterialStateTextStyle
                      .resolveWith((Set<MaterialState> states) {
                    final Color color = states.contains(MaterialState.error)
                        ? Theme.of(context).colorScheme.error :
                    Colors.white;
                    return TextStyle(color: color, letterSpacing: 1);
                  }),
                  prefixIcon: const Icon(
                    Icons.account_circle_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                  hintStyle: const TextStyle(color: Colors.grey),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ),
            Container(
              child: getTextFormFieldPhoneNumberAndPassword(
                context,
                _inputPhoneNumberDataController,
                _inputPasswordDataController,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 30, bottom: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      if(_inputNameDataController.value.text.isNotEmpty
                          && _inputPhoneNumberDataController.value.text.isNotEmpty
                          && _inputPasswordDataController.value.text.isNotEmpty
                          && _formKey.currentState!.validate()) {
                        int checkUserNameOrPhoneNumberInDB = await isUserWithThisNameOrPhoneNumberAlreadyExists(
                          _inputNameDataController.value.text,
                          '+7 ${_inputPhoneNumberDataController.value.text}',
                        );
                        if(checkUserNameOrPhoneNumberInDB == Constants.successNewUserCreate) {
                          if(context.mounted) {
                            _databaseController.addDataToTable(
                                NewUser(
                                    name: _inputNameDataController.text,
                                    phoneNumber: '+7 ${_inputPhoneNumberDataController.text}',
                                    password: _inputPasswordDataController.text
                                ),
                                'users'
                            );
                            if(context.mounted) {
                              context.read<CurrentUserModel>().setCurrentUserAndSharedPreferencesData(
                                true,
                                NewUser(
                                    name: _inputNameDataController.text,
                                    phoneNumber: '+7 ${_inputPhoneNumberDataController.text}',
                                    password: _inputPasswordDataController.text
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
                          }
                        } else if(checkUserNameOrPhoneNumberInDB == Constants.errorNameInUse) {
                          if(context.mounted) {
                            showSnackBar(context, 'Name is already in use');
                          }
                        } else if(checkUserNameOrPhoneNumberInDB == Constants.errorPhoneNumberInUse) {
                          if(context.mounted) {
                            showSnackBar(context, 'Phone is already in use');
                          }
                        }

                      } else {
                        showSnackBar(context, 'Enter valid data');

                      }
                    },
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
                        'Sign Up',
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
            ),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(bottom: 25),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                            const SignInScreenContainerWidget()));
                  },
                  child: const Text(
                      'Account already exists?',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 13,
                      ),
                      textDirection: TextDirection.ltr
                  ),
                )
            )
          ],
        ),
        ),
      );
  }
}


Widget getTextFormFieldPhoneNumberAndPassword(BuildContext context,
    TextEditingController inputPhoneNumberDataController,
    TextEditingController inputPasswordDataController) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        height: 90,
        padding: const EdgeInsets.only(left: 70, right: 70),
        alignment: Alignment.center,
        child: TextFormField(
          inputFormatters: [getPhoneNumberMaskFormatter()],
          controller: inputPhoneNumberDataController,
          keyboardType: TextInputType.phone,
          validator: (value) {
            if(value != null && value != '' && value.length < 15) {
              return 'Invalid phone number';
            }
            return null;
          },
          autovalidateMode: AutovalidateMode.always,
          cursorOpacityAnimates: true,
          cursorColor: Colors.white,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 17
          ),
          decoration:  InputDecoration(
            counterText: '',
            labelText: 'Phone number',
            prefixIcon: const Icon(
              Icons.phone_android,
              color: Colors.white,
              size: 20,
            ),
            prefixText: '+7 ',
            prefixStyle: const TextStyle(
              color: Colors.white,
              fontSize: 17,
            ),
            floatingLabelAlignment: FloatingLabelAlignment.center,
            labelStyle: const TextStyle(color: Colors.grey),
            floatingLabelStyle: MaterialStateTextStyle
                .resolveWith((Set<MaterialState> states) {
              final Color color = states.contains(MaterialState.error)
                  ? Theme.of(context).colorScheme.error :
              Colors.white;
              return TextStyle(color: color, letterSpacing: 1);
            }),
            hintStyle: const TextStyle(color: Colors.grey),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(20.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(20.0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(20.0),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        ),
      ),
      Container(
        height: 90,
        alignment: Alignment.center,
        padding: const EdgeInsets.only(left: 70, right: 70),
        child: TextFormField(
          keyboardType: TextInputType.text,
          controller: inputPasswordDataController,
          validator: (value) {
            if(value != null && value.contains(' ')) {
              return 'Invalid password';
            } else if(value != '' && value!.length < 6) {
              return 'Password min 6 characters';
            }
            return null;
          },
          autovalidateMode: AutovalidateMode.always,
          textAlign: TextAlign.justify,
          cursorOpacityAnimates: true,
          cursorColor: Colors.white,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 17
          ),
          decoration:  InputDecoration(
            labelText: 'Password',
            floatingLabelAlignment: FloatingLabelAlignment.center,
            labelStyle: const TextStyle(color: Colors.grey),
            floatingLabelStyle: MaterialStateTextStyle
                .resolveWith((Set<MaterialState> states) {
              final Color color = states.contains(MaterialState.error)
                  ? Theme.of(context).colorScheme.error :
              Colors.white;
              return TextStyle(color: color, letterSpacing: 1);
            }),
            prefixIcon: const Icon(
              Icons.lock,
              color: Colors.white,
              size: 20,
            ),
            hintStyle: const TextStyle(color: Colors.grey),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(20.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(20.0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(20.0),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        ),
      )
    ],
  );
}


Future<int> isUserWithThisNameOrPhoneNumberAlreadyExists(String userName, String phoneNumber) async {
  int isUserWithThisNameOrPhoneNumberAlreadyExists = Constants.successNewUserCreate;
  List<NewUser> list = await DatabaseController().isDBContainUserWithThisNameOrPhoneNumber(userName, phoneNumber);
  for(NewUser element in list) {
    if(element.name == userName) {
      isUserWithThisNameOrPhoneNumberAlreadyExists = Constants.errorNameInUse;
      return isUserWithThisNameOrPhoneNumberAlreadyExists;
    }
    if(element.phoneNumber == phoneNumber) {
      isUserWithThisNameOrPhoneNumberAlreadyExists = Constants.errorPhoneNumberInUse;
      return isUserWithThisNameOrPhoneNumberAlreadyExists;
    }

  }
  return isUserWithThisNameOrPhoneNumberAlreadyExists;
}



MaskTextInputFormatter getPhoneNumberMaskFormatter() {
  return MaskTextInputFormatter(
    mask: '(___) ___-__-__',
    filter: {'_': RegExp('[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );
}