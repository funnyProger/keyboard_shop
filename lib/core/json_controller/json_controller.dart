import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import '../model_objects/product_objects/product.dart';

class Controller {
  
  Future<List<Product>> readJsonData() async {
    try {
      final fileContent = await rootBundle.loadString('assets/product.json');
      final jsonData = json.decode(fileContent) as List<dynamic>;
      return  jsonData.map((element) => Product.fromJson(element)).toList();
    } catch(e) {
      print(e);
      rethrow;
    }
  }

}
