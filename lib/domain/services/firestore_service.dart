import 'package:cuevaDelRecambio/domain/entities/product.dart';
import 'package:cuevaDelRecambio/domain/utils/parsers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// This static method sends the last version of the cart to the server.
// It is called when the user modifies the cart.
Future<bool> updateCartToFB(List<Product> cart) async {
  User user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    try {
      if (cart.isEmpty) {
        DocumentSnapshot snap = await FirebaseFirestore.instance
            .collection('cart')
            .doc(user.uid)
            .get();
        if (snap.exists) {
          await FirebaseFirestore.instance
              .collection('cart')
              .doc(user.uid)
              .set({});
        }
        return true;
      } else {
        await FirebaseFirestore.instance
            .collection('cart')
            .doc(user.uid)
            .set(parseCart(cart));
        return true;
      }
    } on Exception catch (e) {
      print('$e');
      return false;
    }
  }
  return false;
}

// This static method returns the cart from the server.
// It is called when the user opens the app.
Future<List<Product>> getCartFromFB() async {
  User user = FirebaseAuth.instance.currentUser;
  List<Product> cart = List<Product>.empty(growable: true);

  if (user != null) {
    try {
      await FirebaseFirestore.instance
          .collection('cart')
          .doc(user.uid)
          .get()
          .then((value) async {
        if (!value.exists) {
          await FirebaseFirestore.instance
              .collection('cart')
              .doc(user.uid)
              .set({});
        }
      });

      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('cart')
          .doc(user.uid)
          .get();

      bool empty;
      try {
        print(snapshot.data());
        empty = snapshot.data() as Map<String, dynamic> == {};
      } catch (e) {
        empty = true;
      }

      if (empty) {
        return cart;
      } else {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        data.forEach((key, value) {
          cart.add(Product.productFromId(value["id"], quantity: value["quantity"]));
        });
      }
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }
  return cart;
}
