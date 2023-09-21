import 'package:flutter/material.dart';
import 'package:keyboard_shop/core/models/cart_model.dart';
import 'package:keyboard_shop/core/models/current_user_model.dart';
import 'package:keyboard_shop/giu/widgets/cart_screen_widgets/cart_widget.dart';
import 'package:provider/provider.dart';

class CartScreenContainerWidget extends StatelessWidget {
  const CartScreenContainerWidget({super.key});


  @override
  Widget build(BuildContext context) {

    return WillPopScope(
        onWillPop: () async {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          return true;
        },
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 24, 24, 24),
          body: Container(
            padding: const EdgeInsets.all(7),
            child: const CartWidget(),
          ),
          appBar: AppBar(
            title: Text(
              context.watch<CurrentUserModel>().isCurrentUserLoggedIn() ? context.watch<CartModel>().getCartPrice() : 'Cart',
              style: const TextStyle(fontSize: 20, color: Colors.white),
              textDirection: TextDirection.ltr,
            ),
            backgroundColor: Colors.black,
          ),
        )
    );

  }
}