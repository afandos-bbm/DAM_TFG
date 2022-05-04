import 'package:client_project/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:client_project/main.dart';
import 'package:client_project/themes/dark_theme.dart';
import 'package:client_project/themes/light_theme.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  CartProvider cartProvider;

  @override
  Widget build(BuildContext context) {
    cartProvider = Provider.of<CartProvider>(context);
    List<List<dynamic>> cart = cartProvider.cart;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Container(
              color: MyApp.darkMode
                  ? DarkTheme.backgroundColor
                  : LightTheme.backgroundColor,
              child: productList(context, cart),
            ),
          ),
          Container(
            height: 80,
            color:
                MyApp.darkMode ? DarkTheme.lightColor : LightTheme.lightColor,
            padding: EdgeInsets.only(top: 20, left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("TOTAL"),
                      SizedBox(height: 5),
                      Text(
                        "\$ ${cartProvider.totalPrice}",
                        style: TextStyle(
                            color: MyApp.darkMode
                                ? DarkTheme.primaryColor
                                : LightTheme.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      )
                    ]),
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(MyApp.darkMode
                          ? DarkTheme.primaryColor
                          : LightTheme.primaryColor)),
                  child: Text(
                    "Checkout",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget productList(BuildContext context, List<List<dynamic>> cart) {
    List<Widget> list = [];
    cart.forEach((element) {
      list.add(productItem(context, element[1], element[0], element[2],
          element[3], element[4], element));
    });
    return ListView(children: list);
  }

  Widget productItem(
      BuildContext context,
      final String image,
      final String title,
      final String description,
      final String brand,
      final double price,
      element) {
    return Container(
      height: 120,
      margin: EdgeInsets.all(5),
      child: Row(
        children: <Widget>[
          Container(
              width: 100,
              height: 100,
              margin: EdgeInsets.all(10),
              child: Image.asset(image, fit: BoxFit.fitWidth)),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title),
                Text(
                  "\$ $price",
                  style: TextStyle(
                      color: MyApp.darkMode
                          ? DarkTheme.primaryColor
                          : LightTheme.primaryColor),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Container(
                      height: 39,
                      width: 120,
                      decoration: BoxDecoration(
                          color: MyApp.darkMode
                              ? DarkTheme.lightColor
                              : LightTheme.lightColor,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Row(
                        children: <Widget>[
                          Container(
                              width: 40,
                              alignment: Alignment.center,
                              child: TextButton(
                                child: Text("+",
                                    style: TextStyle(
                                        color: MyApp.darkMode
                                            ? DarkTheme.primaryColor
                                            : LightTheme.primaryColor)),
                                onPressed: () {},
                              )),
                          Container(
                              width: 40,
                              alignment: Alignment.center,
                              child: Text("1")),
                          Container(
                              width: 20,
                              alignment: Alignment.center,
                              child: TextButton(
                                child: Text(
                                  "-",
                                  style: TextStyle(
                                      color: MyApp.darkMode
                                          ? DarkTheme.primaryColor
                                          : LightTheme.primaryColor),
                                ),
                                onPressed: () {},
                              )),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        height: 39,
                        alignment: Alignment.center,
                        child: TextButton(
                          child: Icon(
                            Icons.restore_from_trash,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            List<List<dynamic>> cart = cartProvider.cart;
                            cart.remove(element);
                            cartProvider.cart = cart;
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Removed from cart.")));
                          },
                        )),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
