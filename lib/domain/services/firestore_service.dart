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
            .collection('users')
            .doc(user.uid)
            .get();
        if (snap.exists) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .update({
            'ids': FieldValue.delete(),
            'quantities': FieldValue.delete()
          });
        }
        return true;
      }

      List<int> ids = <int>[];
      List<int> quantities = <int>[];

      cart.forEach((element) {
        print(
            element.id + ' ' + element.quantity.toString() + ' added to cart');
        ids.add(parseInt(element.id));
        quantities.add(element.quantity);
      });

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .set({'ids': ids, 'quantities': quantities});
    } on Exception catch (e) {
      print('$e');
      return false;
    }
    return true;
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
          .collection('users')
          .doc(user.uid)
          .get()
          .then((value) async {
        if (!value.exists) {
          FirebaseFirestore.instance.collection('users').doc(user.uid).set({
            'uid': user.uid,
          });
        }
      });

      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      bool empty;
      try {
        empty = await snapshot.get("uid") == user.uid;
      } catch (e) {
        empty = true;
      }
      if (!empty) {
        return cart;
      } else {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        List<int> cartIds = parseIntList(data['ids']);
        List<int> cartQuantities = parseIntList(data['quantities']);

        cartIds.forEach((element) {
          Product prod = Product.productFromId('$element');
          cart.add(prod);
        });
        int i = 0;
        cartQuantities.forEach((element) {
          int quantity = int.parse('$element');
          if (quantity >= 1) {
            Product prod = Product.productFromId('${cart[i].id}');
            prod.quantity = quantity;
            cart
                .where((element) => element.id == prod.id)
                .toList()
                .forEach((element) {
              element.quantity = quantity;
            });
          }
          i++;
        });
      }
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }
  return cart;
}
