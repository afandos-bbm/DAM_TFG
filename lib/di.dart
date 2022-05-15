import 'package:client_project/domain/entities/product.dart';
import 'package:client_project/domain/services/firestore_service.dart';
import 'package:client_project/domain/services/providers/theme_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'domain/services/providers/cart_provider.dart';

GetIt _l = GetIt.instance;

Future<void> init() async {
  _l.registerFactory(() => FirebaseAuth.instance);
  _l.registerFactory(() => FirebaseFirestore.instance);
  _l.registerFactory(() => FirebaseStorage.instance);

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  _l.registerSingleton<SharedPreferences>(sharedPreferences);

  bool darkMode = sharedPreferences.getBool('darkMode') ?? false;
  _l.registerSingleton(ThemeProvider(darkMode));
}

Future<void> registerCartProvider() async {
  List<Product> cart = await getCartFromFB().then((value) {
    print('Cart loaded from firebase $value');
    return value;
  }).catchError((error) => List<Product>.empty(growable: true));
  _l.registerSingleton<CartProvider>(CartProvider(cart));
}

Future<void> unRegisterCartProvider() async {
  _l.unregister<CartProvider>();
}
