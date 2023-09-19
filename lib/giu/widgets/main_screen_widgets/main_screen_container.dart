import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_shop/giu/widgets/cart_screen_widgets/cart_screen_container.dart';
import 'package:keyboard_shop/giu/widgets/main_screen_widgets/user_profile/profile.dart';
import 'catalog/cart_icon.dart';
import 'catalog/catalog_listview.dart';
import 'favorites/favorites_listview.dart';

class MainScreenContainerWidget extends StatefulWidget {
  const MainScreenContainerWidget({super.key});

  @override
  State<MainScreenContainerWidget> createState() => _MainScreenContainerWidgetState();
}

class _MainScreenContainerWidgetState extends State<MainScreenContainerWidget> {
  int _currentNavIndex = 0;


  final List<Widget> _pages = [
    Container(
      padding: const EdgeInsets.all(7),
      child: const ListViewWidget(),
    ),
    Container(
      padding: const EdgeInsets.all(7),
      child: const FavoritesWidget(),
    ),
    Container(
      padding: const EdgeInsets.all(7),
      child: const UserProfileWidget(),
    )
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
    const Icon(
      Icons.account_circle_outlined,
      color: Colors.white,
      size: 35,
    )
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
                  MaterialPageRoute(builder: (context) =>
                  const CartScreenContainerWidget()),
                );
              },
              child: const CartIconWidget(),
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
