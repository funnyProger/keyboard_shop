import 'package:flutter/material.dart';
import 'package:keyboard_shop/core/models/favorites_model.dart';
import 'package:keyboard_shop/data/model_objects/basket.dart';
import 'package:keyboard_shop/data/model_objects/favorites.dart';
import 'package:provider/provider.dart';
import '../core/models/basket_model.dart';
import '../GIU/widgets/first_screen_widgets/first_screen_container.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Basket.initList();
  await Favorites.initList();


  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BasketModel()),
        ChangeNotifierProvider(create: (context) => FavoritesModel()),
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
      home: DefaultTabController(
          length: 2,
          child: FirstScreenContainer(),
      ),
      debugShowCheckedModeBanner: false,
    );

  }
}
