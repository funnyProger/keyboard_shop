import 'package:flutter/material.dart';
import 'models/product_model.dart';

void main() {
  runApp(const MaterialApp(
    home: ScreenContainer(),
    debugShowCheckedModeBanner: false,
  ));
}

class ScreenContainer extends StatelessWidget {
  const ScreenContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        body: ListWidget(list: getList(),),
        appBar: AppBar(
          title: const Text(
            "Keyboard Shop",
            style: TextStyle(fontSize: 20, color: Colors.white),
            textDirection: TextDirection.ltr,
          ),
          backgroundColor: Colors.black,
        ),
      ),
    );
  }
}

class ListWidget  extends StatefulWidget {
  List<Product> list = [];

  ListWidget({super.key, required this.list});

  @override
  ListState createState() => ListState(list);
}

class ListState extends State<ListWidget> {
  List<Product> list = [];

  ListState(this.list);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      padding: const EdgeInsets.all(7),
      child: ListView.builder(
          itemCount: list.length,
          itemBuilder: listViewBuilder
      ),
    );
  }
  
  Widget listViewBuilder(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        //code...
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          color: Colors.white
        ),
        child: Expanded(
          child: Row(
            children: [
              Expanded(
                flex: 3,
                  child: Container(
                    height: 90,
                    padding: const EdgeInsets.all(5),
                    child: Image.network(list[index].image),
                  )
              ),
              Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      list[index].name,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      textDirection: TextDirection.ltr,
                      softWrap: true,
                    )
                  )
              ),
              Expanded(
                  flex: 2,
                  child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        list[index].price,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        textDirection: TextDirection.ltr,
                      )
                  )
              ),
            ],
          ),
        ),

      ),
    );
  }

}