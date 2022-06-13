import 'dart:convert';
import 'package:cuevaDelRecambio/main.dart';

// Is the most important entity of the application,
// it will be used to store the products of the application.
class Product {
  final String id;
  String name;
  String image;
  String brand;
  double price;
  String description;
  List<String> tags;
  int quantity = 1;

  Product({
    this.id,
    this.name,
    this.image,
    this.brand,
    this.price,
    this.description,
    this.tags,
  });

  Product.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        brand = json['brand'],
        price = json['price'],
        description = json['description'],
        tags = List<String>.from(json['tags']),
        image = json['image'],
        quantity = json['quantity'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'brand': brand,
        'price': price,
        'description': description,
        'tags': tags,
        'image': image,
        'quantity': quantity,
      };

  Map<String, dynamic> toCart() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['price'] = price;
    map['quantity'] = quantity;
    double total = price * quantity;
    map['total'] = total;

    return map;
  }

  // This method will be used to search products by id into the json file.
  static Product productFromId(String id, {int quantity = 1}) {
    Product product;
    String jsonString = MyApp.productsJson;
    List<dynamic> jsonResponse = json.decode(jsonString);
    jsonResponse.forEach((element) {
      if (element['id'] == id) {
        product = Product.fromJson(element);
        product.quantity = quantity;
      }
    });
    return product;
  }
}
