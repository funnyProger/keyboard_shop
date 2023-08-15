import 'package:flutter/material.dart';
import '../../models/product.dart';
import 'listview.dart';

class FirstScreenContainer extends StatelessWidget {
  const FirstScreenContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black87,
        padding: const EdgeInsets.all(7),
        child: ListWidget(list: getList()),
      ),

      //ListWidget(list: getList()),
      appBar: AppBar(
        title: const Text(
          "Keyboard Shop",
          style: TextStyle(fontSize: 20, color: Colors.white),
          textDirection: TextDirection.ltr,
        ),
        backgroundColor: Colors.black,
      ),
    );
  }
}