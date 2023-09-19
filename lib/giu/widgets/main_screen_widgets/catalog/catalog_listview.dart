import 'dart:core';
import 'package:flutter/material.dart';
import 'package:keyboard_shop/data/controllers/json_controller.dart';
import 'package:keyboard_shop/data/model_objects/product/product.dart';
import 'listview_item.dart';

class ListViewWidget extends StatefulWidget {
  const ListViewWidget({super.key});

  @override
  State<ListViewWidget> createState() => _ListViewWidgetState();
}


class _ListViewWidgetState extends State<ListViewWidget> {
  late Future<List<Product>> _productListFromJson;
  JsonController controller = JsonController();


  @override
  void initState() {
    _productListFromJson = controller.getProductList();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: _productListFromJson,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (context, index) {
              return ListViewItemWidget(product: snapshot.data![index]);
            },
            itemCount: snapshot.data!.length,
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text(
              "Ошибка загрузки",
              style: TextStyle(fontSize: 20, color: Colors.white),
              textDirection: TextDirection.ltr,
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

  }
}
