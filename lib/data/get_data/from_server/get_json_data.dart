import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_shop/data/controllers/json_controller.dart';
import 'package:keyboard_shop/data/model_objects/product/product.dart';

class JsonData extends JsonDataInterface {


  @override
  Future<List<Product>> getProductDataFromJson() async {
    try {
      final fileContent = await rootBundle.loadString('assets/product.json');
      final jsonData = json.decode(fileContent) as List<dynamic>;

      return jsonData.map((element) => Product.fromJson(element)).toList();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }
}