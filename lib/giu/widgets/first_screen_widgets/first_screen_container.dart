import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_shop/giu/widgets/basket_screen_widgets/basket_screen_container.dart';
import 'package:keyboard_shop/giu/widgets/first_screen_widgets/catalog/catalog_listview.dart';
import 'package:keyboard_shop/giu/widgets/first_screen_widgets/favorites/favorites_listview.dart';
import 'catalog/basket_icon.dart';

class FirstScreenContainer extends StatefulWidget {
  const FirstScreenContainer({super.key});

  @override
  State<FirstScreenContainer> createState() => _FirstScreenContainerState();
}

class _FirstScreenContainerState extends State<FirstScreenContainer> {
  int _currentNavIndex = 0;
  final List<Widget> _pages = [
    Container(
      padding: const EdgeInsets.all(7),
      child: const ListWidget(),
    ),
    Container(
      padding: const EdgeInsets.all(7),
      child: const FavoritesWidget(),
    ),
  ];
  final List<Icon> icons = [
    const Icon(
      Icons.format_list_bulleted_rounded,
      color: Colors.white,
      size: 35,
    ),
    const Icon(
      Icons.favorite,
      color: Colors.white,
      size: 35,
    ),
  ];


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: IndexedStack(
          index: _currentNavIndex,
          children: _pages,
        ),
        backgroundColor: const Color.fromARGB(255, 24, 24, 24),
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            "Keyboard Shop",
            style: TextStyle(fontSize: 20, color: Colors.white),
            textDirection: TextDirection.ltr,
          ),
          actions: [
            GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).removeCurrentSnackBar();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BasketScreenContainer()),
                );
              },
              child: const BasketIconWidget(),
            ),
          ],
        ),
        bottomNavigationBar: CurvedNavigationBar(
          items: icons,
          height: 55,
          buttonBackgroundColor: Colors.green,
          backgroundColor: Colors.transparent,
          animationDuration: const Duration(milliseconds: 400),
          color: Colors.black87,
          index: _currentNavIndex,
          onTap: _onTapNavBarItem,
        )
    );

  }


  void _onTapNavBarItem(int index) {
    setState(() {
      _currentNavIndex = index;
    });
  }
}
