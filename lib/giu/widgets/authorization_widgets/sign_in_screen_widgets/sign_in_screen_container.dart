import 'package:flutter/material.dart';
import 'package:keyboard_shop/giu/widgets/authorization_widgets/sign_in_screen_widgets/sign_in_screen.dart';

class SignInScreenContainerWidget extends StatelessWidget {
  const SignInScreenContainerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 24, 24, 24),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Keyboard Shop",
          style: TextStyle(fontSize: 20, color: Colors.white),
          textDirection: TextDirection.ltr,
        ),
      ),
      body: const SignInScreenWidget(),
    );
  }

}