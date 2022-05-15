import 'package:client_project/domain/entities/product.dart';
import 'package:client_project/domain/services/firestore_service.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  CartProvider(this._cart) {
    _cart.forEach((element) {
      if (element.quantity > 0) {
        totalPrice += element.quantity * element.price;
      }
    });
  }

  List<Product> _cart;
  double totalPrice = 0;
  bool loading = false;

  List<Product> get cart => _cart;

  set cart(List<Product> cart) {
    cart.forEach((element) {
      if (element.quantity > 0) {
        totalPrice += element.quantity * element.price;
      }
    });
    _cart = cart;
    notifyListeners();
  }

  void addProduct(Product product) {
    int index = _cart.indexWhere((element) => element.id == product.id);

    if (index == -1) {
      totalPrice += product.price;
      _cart.add(product);
    } else {
      _cart[index].quantity++;
      totalPrice += product.price;
    }

    updateCartToFB(_cart);
    notifyListeners();
  }

  void removeProduct(Product product, bool removeAll) {
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
    updateCartToFB(_cart);
    notifyListeners();
  }
}
