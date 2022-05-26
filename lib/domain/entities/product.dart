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
  List<dynamic> variantes;
  int quantity = 1;

  Product({
    this.id,
    this.name,
    this.image,
    this.variantes,
    this.brand,
    this.price,
    this.description,
    this.tags,
  });

  Product.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['nombre'],
        brand = json['marca'],
        price = json['precio'],
        description = json['descripcion'],
        tags = List<String>.from(json['tags']),
        image = json['imagen'],
        variantes = json['variantes'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'nombre': name,
        'marca': brand,
        'precio': price,
        'descripcion': description,
        'tags': tags,
        'imagen': image,
        'variantes': variantes,
      };

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
