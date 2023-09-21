import 'package:flutter/material.dart';
import 'package:keyboard_shop/giu/widgets/authorization_widgets/sign_up_screen_widgets/sign_up_screen.dart';

class SignUpScreenContainerWidget extends StatelessWidget {
  const SignUpScreenContainerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 24, 24, 24),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Keyboard Shop",
          style: TextStyle(fontSize: 20, color: Colors.white),
          textDirection: TextDirection.ltr,
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: const SingleChildScrollView(
          child: SignUpScreenWidget(),
        ),
      ),
    );
  }
}