import 'dart:convert';

import 'package:cuevaDelRecambio/domain/entities/product.dart';
import 'package:cuevaDelRecambio/main.dart';
import 'package:cuevaDelRecambio/ui/widgets/product/product_card.dart';
import 'package:flutter/material.dart';

class ProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(scrollDirection: Axis.horizontal, children: getProducts());
  }

  List<ProductCard> getProducts() {
    List<Product> products = [];
    String jsonString = MyApp.productsJson;
    List<dynamic> jsonResponse = json.decode(jsonString);
    jsonResponse.forEach((element) => products.add(Product(
          id: element['id'],
          name: element['nombre'],
          image: element['imagen'],
          brand: element['marca'],
          price: element['precio'],
          description: element['descripcion'],
          tags: List<String>.from(element['tags']),
        )));
    List<ProductCard> categories = [];
    products.forEach((element) => categories.add(ProductCard(
          name: element.name,
          image: element.image,
          brand: element.brand,
          description: element.description,
          price: element.price,
          tags: element.tags,
          id: element.id,
        )));
    return categories;
  }
}
