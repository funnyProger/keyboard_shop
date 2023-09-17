import 'package:flutter/material.dart';
import 'package:keyboard_shop/core/models/favorites_model.dart';
import 'package:keyboard_shop/data/model_objects/cart/cart.dart';
import 'package:keyboard_shop/data/model_objects/favorite/favorites.dart';
import 'package:keyboard_shop/giu/widgets/main_screen_widgets/main_screen_container.dart';
import 'package:provider/provider.dart';
import '../core/models/cart_model.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Cart.initList();
  await Favorites.initList();


  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartModel()),
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
          child: MainScreenContainerWidget(),
      ),
      debugShowCheckedModeBanner: false,
    );

  }
}
