import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/models/basket_model.dart';
import '../GIU/widgets/first_screen_widgets/first_screen_container.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BasketModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: FirstScreenContainer(),
      debugShowCheckedModeBanner: false,
    );
  }

}