import 'package:flutter/material.dart';
import 'package:keyboard_shop/core/models/favorites_model.dart';
import 'package:keyboard_shop/core/models/current_user_model.dart';
import 'package:keyboard_shop/data/model_objects/cart/cart.dart';
import 'package:keyboard_shop/data/model_objects/favorite/favorites.dart';
import 'package:keyboard_shop/giu/widgets/main_screen_widgets/main_screen_container.dart';
import 'package:provider/provider.dart';
import '../core/models/cart_model.dart';


void main() async {
  await initAppData();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartModel()),
        ChangeNotifierProvider(create: (context) => FavoritesModel()),
        ChangeNotifierProvider(create: (context) => CurrentUserModel()),
      ],
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});


  @override
  State<MyApp> createState() => MyAppState();
}


class MyAppState extends State<MyApp> {

  @override
  void initState() {
    context.read<CurrentUserModel>().initAndCheckSharedPreferencesData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: const MainScreenContainerWidget(),
      routes: <String, WidgetBuilder> {
        'main': (BuildContext context) => const MainScreenContainerWidget()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}


initAppData() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Cart.initList();
  await Favorites.initList();
}