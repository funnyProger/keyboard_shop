import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:keyboard_shop/data/controllers/database_controller.dart';
import 'package:keyboard_shop/data/controllers/device_storage_controller.dart';
import 'package:keyboard_shop/data/model_objects/user/new_user.dart';
import 'package:keyboard_shop/giu/widgets/authorization_widgets/sign_in_screen_widgets/sign_in_screen_container.dart';
import 'package:keyboard_shop/giu/widgets/main_screen_widgets/catalog/listview_item.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

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
  final DeviceStorageController _deviceDataController = DeviceStorageController();
  Uint8List? _imageFromDevice;

  @override
  void dispose() {
    _inputNameDataController.dispose();
    _inputPhoneNumberDataController.dispose();
    _inputPasswordDataController.dispose();
    super.dispose();
  }

  Future getFileFromDevice() async {
    Uint8List? returnedImage = await _deviceDataController.getGalleryData();
    if(returnedImage != null) {
      _imageFromDevice = returnedImage;
    }
    setState(() {
      _imageFromDevice;
    });
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
                flex: 8,
                child: Container(
                  alignment: Alignment.center,
                  child: const Text(
                    "Registration",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30  ,
                    ),
                    textDirection: TextDirection.ltr,
                  ),
                )
            ),
            Expanded(
                flex: 16,
                child: Container(
                  alignment: Alignment.center,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: () async {
                      getFileFromDevice();
                    },
                    child: _imageFromDevice != null ? CircleAvatar(
                      backgroundColor: Colors.black54,
                      radius: 100,
                      backgroundImage: MemoryImage(_imageFromDevice!),
                    ) : CircleAvatar(
                      backgroundColor: Colors.black54,
                      radius: 100,
                      child: SvgPicture.asset('assets/images/default_male_avatar_1.svg'),
                    )
                  )
                )
            ),
            Expanded(
                flex: 4,
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Add an avatar',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                    textDirection: TextDirection.ltr,
                  ),
                )
            ),
            Expanded(
                flex: 7,
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(left: 60, right: 60),
                  child: Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
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
                      )
                  ),
                )
            ),
            Expanded(
              flex: 14,
              child: getTextFormFieldPhoneNumberAndPassword(
                context,
                _inputPhoneNumberDataController,
                _inputPasswordDataController,
              ),
            ),
            Expanded(
                flex: 10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        if(_inputNameDataController.value.text.isNotEmpty
                            && _inputPhoneNumberDataController.value.text.isNotEmpty
                            && _inputPasswordDataController.value.text.isNotEmpty
                            && _formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context)
                              .removeCurrentSnackBar();
                          ScaffoldMessenger.of(context)
                              .showSnackBar(
                              getSnackBar('Successfully'));
                          String defaultImage = await rootBundle.loadString('assets/images/default_male_avatar_1.svg');
                          _databaseController.addDataToTable(
                              NewUser(
                                  image: _imageFromDevice == null
                                      ? defaultImage
                                      : base64Encode(_imageFromDevice as List<int>),
                                  name: _inputNameDataController.text,
                                  phoneNumber: _inputPhoneNumberDataController.text,
                                  password: _inputPasswordDataController.text
                              ),
                              'users'
                          );
                        } else {
                          ScaffoldMessenger.of(context)
                              .removeCurrentSnackBar();
                          ScaffoldMessenger.of(context)
                              .showSnackBar(
                              getSnackBar('Enter valid data'));
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
                    Container(
                        padding: const EdgeInsets.only(top: 15),
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
                )
            )
          ],
        ),
      )
    );
  }
}


Widget getTextFormFieldPhoneNumberAndPassword(BuildContext context,
    TextEditingController inputPhoneNumberDataController,
    TextEditingController inputPasswordDataController) {
  return Column(
    children: [
      Expanded(
          flex: 5,
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 60, right: 60),
            child: Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: IntlPhoneField(
                  inputFormatters: [getPhoneNumberMaskFormatter()],
                  controller: inputPhoneNumberDataController,
                  keyboardType: TextInputType.phone,
                  initialCountryCode: 'RU',
                  cursorColor: Colors.white,
                  dropdownIcon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white,
                  ),
                  dropdownTextStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 17
                  ),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17
                  ),
                  decoration:  InputDecoration(
                    counterText: '',
                    labelText: 'Phone number',
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
                )
            ),
          )
      ),
      Expanded(
          flex: 5,
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 60, right: 60),
            child: Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
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
                )
            ),
          )
      ),
    ],
  );
}


MaskTextInputFormatter getPhoneNumberMaskFormatter() {
  return MaskTextInputFormatter(
    filter: {'_': RegExp('[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );
}