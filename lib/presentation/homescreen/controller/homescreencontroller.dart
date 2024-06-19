import 'dart:convert';
import 'package:fakestoretestapi/model/modelapi.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

class HomeScreenController with ChangeNotifier {
  static List productList = [];

  static List productKeys = [];
  var myBox = Hive.box("products");
  void addData({
    required String title,
    required String img,
    required String description,
    required String price,
    required String rating,
  }) {
    myBox.add({
      "title": title,
      "img": img,
      "description": description,
      "price": price,
      "rating": rating,
    });
    notifyListeners();
  }

  void deleteData(int index) {
    myBox.deleteAt(index);
    productKeys = myBox.keys.toList();
    notifyListeners();
  }

  List<SampleApiModel> productlist = [];
  fetchData() async {
    var url = Uri.parse("https://fakestoreapi.com/products");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body) as List;

      productlist = decodedData
          .map<SampleApiModel>((element) => SampleApiModel.fromJson(element))
          .toList();
      print(productlist[1].category);
      notifyListeners();
    }
  }
}
