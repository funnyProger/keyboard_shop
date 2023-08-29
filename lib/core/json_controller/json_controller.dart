import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:keyboard_shop/core/model_objects/json_data/product_list.dart';

class Controller {
  
  Future<ProductList> fetchProductList() async {
    File jsonFile = File('product.txt');
    try {
      String content = await jsonFile.readAsString();
      print(content);
      return ProductList.fromJson(jsonDecode(content));
    } catch(e) {
      print(e);
      rethrow;
    }
  }


}
