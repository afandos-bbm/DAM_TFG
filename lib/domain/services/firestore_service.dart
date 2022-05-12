import 'package:client_project/domain/entities/producto.dart';
import 'package:client_project/domain/utils/parsers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<bool> updateCartToFB(List<Producto> cart) async {
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
              .update({'ids': FieldValue.delete(), 'quantity': FieldValue.delete()});
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

Future<List<Producto>> getCartFromFB() async {
  User user = FirebaseAuth.instance.currentUser;
  List<Producto> cart = List<Producto>.empty(growable: true);

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
          Producto prod = Producto.productoFromId('$element');
          cart.add(prod);
        });
        int i = 0;
        cartQuantities.forEach((element) {
          int quantity = int.parse('$element');
          if (quantity >= 1) {
            Producto prod = Producto.productoFromId('${cart[i].id}');
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
