import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keyboard_shop/core/controllers/data_controller.dart';
import 'package:keyboard_shop/core/models/basket_model.dart';
import 'package:provider/provider.dart';
import 'package:keyboard_shop/core/model_objects/product_objects/product.dart';
import '../info_screen_widgets/info_screen_container.dart';

class ListWidget extends StatefulWidget {
  const ListWidget({super.key});

  @override
  State<ListWidget> createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  late Future<List<Product>> productList;
  Controller controller = Controller();

  @override
  void initState() {
    super.initState();
    productList = controller.getProductData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: productList,
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
              ),
              itemBuilder: (context, index) {
                return itemBuilder(context, snapshot.data![index]);
              },
              itemCount: snapshot.data?.length,
            );
          } else if(snapshot.hasError) {
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

  Widget itemBuilder(BuildContext context, Product product) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InfoScreenContainer(product: product)
          )
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(5),
        child:  Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(17),
              color: Colors.white
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 14,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  child: Image.network(product.image)
                ),
              ),

              Expanded(
                  flex: 2,
                  child: Container(
                      padding: const EdgeInsets.only(left: 9),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        getString(product.price),
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        textDirection: TextDirection.ltr,
                      )
                  )
              ),
              Expanded(
                  flex: 8,
                  child: Container(
                      padding: const EdgeInsets.only(left: 10, top: 5, right: 10),
                      alignment: Alignment.topLeft,
                      child: Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        textDirection: TextDirection.ltr,
                        softWrap: true,
                      )
                  )
              ),
              Expanded(
                flex: 6,
                child: GestureDetector(
                    onTap: () {
                      context.read<BasketModel>().addToBasket(product);
                      Fluttertoast.showToast(
                        msg: "Успешно добавлено",
                        toastLength: Toast.LENGTH_SHORT,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 15,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.only(top: 1, bottom: 10),
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: 100,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.indigoAccent
                        ),
                        child: const Text(
                          "В корзину",
                          style: TextStyle(fontSize: 13, color: Colors.white),
                          textDirection: TextDirection.ltr,
                        ),
                      ),
                    )
                ),
              )

            ],
          ),
        ),
      )
    );
  }

}