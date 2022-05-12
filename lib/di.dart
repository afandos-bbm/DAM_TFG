import 'package:client_project/domain/entities/producto.dart';
import 'package:client_project/domain/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'domain/services/providers/cart_provider.dart';

GetIt _l = GetIt.instance;

Future<void> init() async {
  _l.registerFactory(() => FirebaseAuth.instance);
  _l.registerFactory(() => FirebaseFirestore.instance);

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  _l.registerSingleton<SharedPreferences>(sharedPreferences);

  List<Producto> cart = await getCartFromFB().then((value) {
    print('Cart loaded from firebase $value');
    return value;
  }).catchError((error) => List<Producto>.empty(growable: true));
  _l.registerSingleton<CartProvider>(CartProvider(cart));
}
