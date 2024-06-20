// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:fakestoretestapi/core/constants/textscon.dart';
import 'package:flutter/material.dart';

class ShopContainer extends StatelessWidget {
  const ShopContainer({
    super.key,
    required this.img,
    required this.title,
    required this.category,
    required this.price,
    required this.rating,
  });
  final String img;
  final String title;
  final String rating;

  final dynamic price;
  final String category;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 200,
      decoration: BoxDecoration(
        border: Border.symmetric(),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [Icon(Icons.favorite_border)],
            ),
          ),
          Container(
            height: 160,
            decoration:
                BoxDecoration(image: DecorationImage(image: NetworkImage(img))),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: MytextStyle.Titlen,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  category,
                  style: MytextStyle.Categoryn,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  Text(
                    rating,
                    style: MytextStyle.Ratingn,
                  ),
                ],
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  price,
                  style: MytextStyle.Pricen,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
