import 'dart:convert';
import 'package:client_project/main.dart';

class Producto {
  final String id;
  String name;
  String image;
  String brand;
  double price;
  String description;
  List<String> tags;
  List<dynamic> variantes;
  int quantity = 1;

  Producto({
    this.id,
    this.name,
    this.image,
    this.variantes,
    this.brand,
    this.price,
    this.description,
    this.tags,
  });

  Producto.fromJson(Map<String, dynamic> json)
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

  static Producto productoFromId(String id, {int quantity = 1}) {
    Producto product;
    String jsonString = MyApp.productsJson;
    List<dynamic> jsonResponse = json.decode(jsonString);
    jsonResponse.forEach((element) {
      if (element['id'] == id) {
        product = Producto.fromJson(element);
        product.quantity = quantity;
      }
    });
    return product;
  }

  @override
  String toString() {
    return 'Producto{id: $id, name: $name, image: $image, brand: $brand, price: $price, description: $description, tags: $tags, variantes: $variantes, quantity: $quantity}';
  }
}
