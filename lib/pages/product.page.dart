import 'package:client_project/providers/cart_provider.dart';
import 'package:client_project/themes/dark_theme.dart';
import 'package:client_project/themes/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class ProductPage extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final String brand;
  final double price;

  ProductPage(
      {@required this.image,
      @required this.title,
      @required this.brand,
      @required this.price,
      @required this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  backgroundColor: Colors.white.withOpacity(0),
                  elevation: 0.0,
                  expandedHeight: 500,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    background: Image.asset(image,
                        width: double.infinity, fit: BoxFit.fitWidth),
                  ),
                )
              ];
            },
            body: ListView(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: Text(title,
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold))),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(brand),
                ),
                Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(description,
                        style: TextStyle(fontWeight: FontWeight.bold))),
              ],
            )),
        floatingActionButton: ElevatedButton(
          onPressed: () {
            final cartProvider =
                Provider.of<CartProvider>(context, listen: false);
            List<List<dynamic>> cart = cartProvider.cart;
            cart.add([title, image, description, brand, price]);
            cartProvider.cart = cart;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Added to cart"),
            ));
          },
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(MyApp.darkMode
                  ? DarkTheme.primaryColor
                  : LightTheme.primaryColor)),
          child: Icon(Icons.add_shopping_cart),
        ));
  }
}
