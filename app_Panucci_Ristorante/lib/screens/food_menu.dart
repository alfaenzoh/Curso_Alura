import 'package:flutter/material.dart';
import 'package:panucci_ristorante/components/food_item.dart';

import '../cardapio.dart';

class FoodMenu extends StatelessWidget {
  const FoodMenu({super.key});

  final List foods = comidas;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
      child: CustomScrollView(
        slivers: <Widget>[
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: Text(
                "Menu",
                style: TextStyle(fontSize: 32, fontFamily: "Caveat"),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            (context, index) {
              return FoodItem(
                  itemTitle: foods[index]["name"],
                  itemPrice: foods[index]["price"],
                  imageURI: foods[index]["image"]);
            },
            childCount: foods.length,
          ))
        ],
      ),
    );
  }
}
