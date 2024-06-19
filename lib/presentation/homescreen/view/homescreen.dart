// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:fakestoretestapi/presentation/cartscreen/cartscreen.dart';
import 'package:fakestoretestapi/presentation/detailedscreen/view/detailedscreen.dart';
import 'package:fakestoretestapi/presentation/homescreen/controller/homescreencontroller.dart';
import 'package:fakestoretestapi/presentation/homescreen/widgets/shopcontainer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    await Provider.of<HomeScreenController>(context, listen: false).fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final homescreenProvider = Provider.of<HomeScreenController>(context);

    return Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("ShoppHolic"),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Cartscreen(),
                  ),
                );
              },
              icon: const Icon(
                Icons.shopping_bag,
                color: Colors.black,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 15,
                mainAxisExtent: 320,
                crossAxisSpacing: 15,
                crossAxisCount: 2),
            itemCount: homescreenProvider.productlist.length,
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailedScreen(
                        img: homescreenProvider.productlist[index].image ?? "",
                        title:
                            homescreenProvider.productlist[index].title ?? "",
                        description:
                            homescreenProvider.productlist[index].description ??
                                "",
                        price:
                            "\$${homescreenProvider.productlist[index].price ?? ""}",
                        rating: homescreenProvider
                                .productlist[index].rating?.rate
                                .toString() ??
                            "",
                      ),
                    ));
              },
              child: ShopContainer(
                img: homescreenProvider.productlist[index].image ?? "",
                category: homescreenProvider.productlist[index].category ?? "",
                price: "\$${homescreenProvider.productlist[index].price ?? ""}",
                title: homescreenProvider.productlist[index].title ?? "",
                rating: homescreenProvider.productlist[index].rating?.rate
                        .toString() ??
                    "",
              ),
            ),
          ),
        ));
  }
}
