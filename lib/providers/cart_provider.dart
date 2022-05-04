import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  List<List<dynamic>> _cart = [];
  double totalPrice = 0;

  List<List<dynamic>> get cart => _cart;

  
  set cart(List<List<dynamic>> cart) {
    cart.forEach((element) {
      totalPrice += element[4];
    });
    _cart = cart;
    notifyListeners();
  }
}
