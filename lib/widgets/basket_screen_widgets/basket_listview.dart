import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keyboard_shop/models/basket.dart';
import '../../models/product.dart';

//widget class
class BasketWidget extends StatefulWidget {
  const BasketWidget({super.key});
  @override
  ListState createState() => ListState();
}

//state widget class
class ListState extends State<BasketWidget> {

  //map хранит слудующие пары (product, count), где count - количество
  //данного товара, которое пользователь добавил в корзину

  Map<Product, int> map = {};
  List<Product> list = [];

  /*
  Это сделано для того, чтобы в корзине не отображались одни и те же товары
  в списке. Вместе этого в корзине у каждого товара в есть счетчик, которые
  указывает, какое количество данного товара пользователь добавил в корзину.
  Если польователь захочет добавить товар еще, он может сделать это, нажав на
  кнопку плюсика или в списке всех товаров, нажав на кнопку "В корзину".
  После этого счетчик обновится и корзина отобразит соответствующие изменения.
  Кнопка минуса уменьшает количество выбранного товара на единицу. Если счетчик
  показывает 1, то при нажатии на кнопку минус товар удаляется из списка и
  корзина отображает соответствующие изменения.
   */

  //basket price
  String totalPrice() {
    int basketPrice = 0;
    map.forEach((key, value) {
      basketPrice = basketPrice + (key.price * value);
    });
    //вызов метода getString() из класса Product для преобразования стоимости
    //корзины в строку нужного вида
    return getString(basketPrice);
  }

  @override
  Widget build(BuildContext context) {
    map = Basket.getInstance().map;
    list = Basket.getInstance().getKeys().toList();

    String toBuy = "";
    if(map.isEmpty) {
      toBuy = "Корзина";
    } else {
      toBuy = "К оплате: ${totalPrice()}";
    }

    if(map.isEmpty) {
      return
        Scaffold(
          body: Container(
            color: Colors.black87,
            padding: const EdgeInsets.all(7),
            child: const Center(
              child: Text(
                  "Корзина пуста",
                  style: TextStyle(fontSize: 17, color: Colors.white54),
                  textDirection: TextDirection.ltr
              ),
            )
          ),
          appBar: AppBar(
            title: Text(
              toBuy,
              style: const TextStyle(fontSize: 20, color: Colors.white),
              textDirection: TextDirection.ltr,
            ),
            backgroundColor: Colors.black,
          ),
        );
    } else {
      return Stack(
        children: [
          Scaffold(
            body: Container(
              color: Colors.black87,
              padding: const EdgeInsets.all(7),
              child: ListView.builder(
                  itemCount: list.length + 1,
                  itemBuilder: listViewBuilder
              ),
            ),
            appBar: AppBar(
              title: Text(
                toBuy,
                style: const TextStyle(fontSize: 20, color: Colors.white),
                textDirection: TextDirection.ltr,
              ),
              backgroundColor: Colors.black,
            ),
          ),

          Container(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    Basket.getInstance().buy();
                    Fluttertoast.showToast(
                      msg: "Успешно оплачено",
                      toastLength: Toast.LENGTH_SHORT,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 15,
                    );
                  });
                },
                child: Container(
                  height: 50,
                  width: 250,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 15, bottom: 15),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Text(
                    "Купить",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                    textDirection: TextDirection.ltr,
                  ),
                ),
              )
          )
        ],
      );
    }
  }

  //listViewBuilder
  Widget listViewBuilder(BuildContext context, int index) {
    if(index == list.length) {
      return Container(
        height: 75,
      );
    } else {
      return
        listItem(index);
    }

  }

  //listViewItem
  Widget listItem(int index) {
    return
      Container(
          margin: const EdgeInsets.symmetric(vertical: 3),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(17),
              color: Colors.white
          ),
          child: Row(
            children: [
              Expanded(
                  flex: 10,
                  child: Container(
                    height: 90,
                    padding: const EdgeInsets.all(5),
                    child: Image.network(list[index].image),
                  )
              ),
              Expanded(
                  flex: 9,
                  child: Container(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        list[index].name,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                        textDirection: TextDirection.ltr,
                        softWrap: true,
                      )
                  )
              ),
              Expanded(
                  flex: 9,
                  child: Row(
                    children: [
                      Expanded(
                        flex:3,
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            getString(list[index].price),
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                            textDirection: TextDirection.ltr,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  Basket.getInstance().addToBasket(list[index]);
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.all(3),
                                alignment: Alignment.center,
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.green,
                                ),
                                child: const Text(
                                  "+",
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),

                            Container(
                              margin: const EdgeInsets.all(3),
                              alignment: Alignment.center,
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.black12
                              ),
                              child: Text(
                                map[list[index]].toString(),
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),

                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  Basket.getInstance().removeFromBasket(list[index]);
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.all(3),
                                alignment: Alignment.center,
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.red,
                                ),
                                child: const Text(
                                  "-",
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
              ),
            ],
          )

      );
  }

}