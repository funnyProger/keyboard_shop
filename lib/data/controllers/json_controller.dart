import 'package:keyboard_shop/data/get_data/from_server/get_json_data.dart';
import 'package:keyboard_shop/data/model_objects/product/product.dart';

abstract class JsonDataInterface {
  getProductDataFromJson();
}


class JsonController {
  final JsonDataInterface _implementationObject = JsonData();


  Future<List<Product>> getProductList() async {
    return _implementationObject.getProductDataFromJson();
  }
}