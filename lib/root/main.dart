import 'package:flutter/material.dart';
import 'package:keyboard_shop/widgets/info_screen_widgets/info_screen_container.dart';
import '../widgets/first_screen_widgets/first_screen_container.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: 'first_screen',
    routes: {
      'first_screen': (context) => const FirstScreenContainer(),
      "info": (context) => const InfoScreenContainer()
    },
    debugShowCheckedModeBanner: false,
  ));
}



