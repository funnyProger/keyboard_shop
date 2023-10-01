import 'package:flutter/material.dart';
import 'package:keyboard_shop/core/models/cart_model.dart';
import 'package:keyboard_shop/core/models/current_user_model.dart';
import 'package:provider/provider.dart';

class CartIconWidget extends StatelessWidget {
  const CartIconWidget({super.key});


  @override
  Widget build(BuildContext context) {

    if(context.watch<CurrentUserModel>().isCurrentUserLoggedIn()) {
      if (context.watch<CartModel>().getCartCount() == 0) {
        return Container(
          width: 29,
          margin: const EdgeInsets.only(right: 15),
          child: Image.asset('assets/images/cart.png'),
        );
      } else {
        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 29,
              margin: const EdgeInsets.only(right: 15),
              child: Image.asset('assets/images/cart.png'),
            ),
            Positioned(
                left: 20,
                top: 10,
                child: Container(
                  alignment: Alignment.center,
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.red,
                  ),
                  child: Text(
                    context.watch<CartModel>().getCartCount().toString(),
                    style: const TextStyle(fontSize: 11, color: Colors.white),
                    textDirection: TextDirection.ltr,
                  ),
                )
            )
          ],
        );
      }
    } else {
      return Container(
        width: 29,
        margin: const EdgeInsets.only(right: 15),
        child: Image.asset('assets/images/cart.png'),
      );
    }

  }
}