// Parsers file for the domain package,
// this file will be used to parse the json files
// and convert them to the domain entities.

import 'package:cuevaDelRecambio/domain/entities/product.dart';

List<int> parseIntList(List<dynamic> data) {
  List<int> parsed = List<int>.empty(growable: true);
  data.forEach((element) {
    parsed.add(int.parse('$element'));
  });
  return parsed;
}

int parseInt(String id) {
  return int.parse(id);
}

String parseEmail(String data) {
  if (data.contains('@') &&
      data.contains('.') &&
      data.length > 5 &&
      data.length < 100 &&
      data.contains(' ') == false) {
    return data;
  } else {
    return null;
  }
}

double parsePrice(double data) {
  if (data.toString().contains('.') &&
      data.toString().length > data.toString().indexOf('.') + 3) {
    double price = double.parse(
        data.toString().substring(0, data.toString().indexOf('.') + 3));
    return price;
  } else {
    return data;
  }
}

Map<String, dynamic> parseCart(List<Product> cart) {
  Map<String, dynamic> data = Map<String, dynamic>();
  for (int i = 0; i < cart.length; i++) {
    data[i.toString()] = cart[i].toCart();
  }
  return data;
}
