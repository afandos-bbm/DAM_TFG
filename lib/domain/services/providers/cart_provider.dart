import 'package:client_project/domain/entities/producto.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  List<Producto> _cart = List<Producto>.empty(growable: true);
  double totalPrice = 0;

  List<Producto> get cart => _cart;

  set cart(List<Producto> cart) {
    cart.forEach((element) {
      totalPrice += element.price;
    });
    _cart = cart;
    notifyListeners();
  }

  void addProduct(Producto product) {
    if (_cart.any((element) => element.id == product.id)) {
      print('Producto ya existe');
      _cart.forEach((element) {
        if (element.id == product.id) {
          element.quantity++;
          totalPrice += element.price;
        }
      });
    } else {
      product.quantity = 1;
      _cart.add(product);
      totalPrice += product.price;
    }
    notifyListeners();
  }

  void removeProduct(Producto product, bool removeAll) {
    if (_cart
        .any((element) => element.id == product.id && element.quantity > 1)) {
      if (removeAll) {
        int quantity;
        _cart.forEach((element) {
          if (element.id == product.id) {
            quantity = element.quantity;
          }
        });
        _cart.removeWhere((element) => element.id == product.id);
        totalPrice -= quantity * product.price;
      } else {
        _cart.forEach((element) {
          if (element.id == product.id) {
            element.quantity--;
          }
        });
        totalPrice -= product.price;
      }
    } else {
      _cart.removeWhere((element) {
        return element.id == product.id;
      });
      totalPrice -= product.price;
    }
    notifyListeners();
  }
}
