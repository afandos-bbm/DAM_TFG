import 'package:cuevaDelRecambio/domain/entities/product.dart';
import 'package:cuevaDelRecambio/domain/services/firestore_service.dart';
import 'package:cuevaDelRecambio/domain/utils/parsers.dart';
import 'package:flutter/material.dart';

// This class manages the state of auth and the current user.
// It is a singleton class. It is used to get the current user,
// change the user and know if user is logged in or not.
// The ChangeNotifier is used to notify the widgets.
// The widgets will be repainted.
class CartProvider with ChangeNotifier {
  CartProvider(this._cart) {
    _cart.forEach((element) {
      if (element.quantity > 0) {
        totalPrice += element.quantity * element.price;
        totalPrice = parsePrice(totalPrice);
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
        totalPrice = parsePrice(totalPrice);
      }
    });
    _cart = cart;
    notifyListeners();
  }

  void addProduct(Product product) {
    int index = _cart.indexWhere((element) => element.id == product.id);

    if (index == -1) {
      totalPrice = parsePrice(totalPrice + product.price);
      _cart.add(product);
    } else {
      _cart[index].quantity++;
      totalPrice = parsePrice(totalPrice + product.price);
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
        totalPrice = parsePrice(totalPrice - (quantity * product.price));
      } else {
        _cart.forEach((element) {
          if (element.id == product.id) {
            element.quantity--;
          }
        });
        totalPrice = parsePrice(totalPrice - product.price);
      }
    } else {
      _cart.removeWhere((element) {
        return element.id == product.id;
      });
      totalPrice = parsePrice(totalPrice - product.price);

      if (_cart.isEmpty) {
        totalPrice = 0;
      }
    }
    updateCartToFB(_cart);
    notifyListeners();
  }
}
