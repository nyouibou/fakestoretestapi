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
              decoration: BoxDecoration(),
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
                      color: Colors.red,
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
                        SizedBox(
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
            child: Row(children: [
          Expanded(child: Text('Total: \$0')),
          SizedBox(width: 16.0),
          Expanded(
            child: FilledButton(
              onPressed: () {},
              child: const Text('Pay Now'),
            ),
          )
        ])));
  }
}
