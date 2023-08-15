import 'package:flutter/material.dart';

import 'info.dart';

class InfoScreenContainer extends StatelessWidget {
  const InfoScreenContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black87,
        child: const Info(),
      ),
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