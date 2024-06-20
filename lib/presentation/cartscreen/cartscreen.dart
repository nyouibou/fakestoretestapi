// ignore_for_file: use_key_in_widget_constructors

import 'package:fakestoretestapi/core/constants/textscon.dart';
import 'package:fakestoretestapi/presentation/homescreen/controller/homescreencontroller.dart';
import 'package:fakestoretestapi/presentation/homescreen/view/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cartscreen extends StatefulWidget {
  const Cartscreen({Key? key});

  @override
  State<Cartscreen> createState() => _CartscreenState();
}

class _CartscreenState extends State<Cartscreen> {
  @override
  Widget build(BuildContext context) {
    final homescreenProvider = Provider.of<HomeScreenController>(context);

    double calculateTotal() {
      double total = 0.0;
      for (var i = 0; i < homescreenProvider.myBox.length; i++) {
        var product = homescreenProvider.myBox.getAt(i);
        // print('Product price: ${product['price']}');
        String priceString = product['price'].toString().replaceAll('\$', '');
        double? price = double.tryParse(priceString);
        if (price != null) {
          total += price;
        } else {
          print('Error parsing price for product: ${product['title']}');
        }
      }
      return total;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        leading: InkWell(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ),
            );
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: homescreenProvider.myBox.length,
        itemBuilder: (context, index) {
          var product = homescreenProvider.myBox.getAt(index);
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(product['img'] ?? ""),
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product['title'] ?? "",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: MytextStyle.CartTitle,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        product['price'] ?? "",
                        style: MytextStyle.CartPrice,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              homescreenProvider.deleteData(index);
                              setState(() {});
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.blue),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: const Text("Remove"),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Total: \$${calculateTotal().toStringAsFixed(2)}'),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: FilledButton(
                  onPressed: () {},
                  child: const Text('Pay Now'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
