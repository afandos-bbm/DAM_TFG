import 'package:cuevaDelRecambio/domain/entities/product.dart';
import 'package:cuevaDelRecambio/domain/services/providers/cart_provider.dart';
import 'package:cuevaDelRecambio/domain/services/providers/theme_provider.dart';
import 'package:cuevaDelRecambio/ui/themes/dark_theme.dart';
import 'package:cuevaDelRecambio/ui/themes/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Widget> cartList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<CartProvider>(
        builder: (_, snap, __) {
          if (snap.loading == true) {
            return CircularProgressIndicator();
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Container(
                  color: Provider.of<ThemeProvider>(context).isDarkMode
                      ? DarkTheme.backgroundColor
                      : LightTheme.backgroundColor,
                  child: snap.cart.isEmpty
                      ? emptyCart()
                      : productCartList(context),
                ),
              ),
              Container(
                height: 80,
                color: Provider.of<ThemeProvider>(context).isDarkMode
                    ? DarkTheme.lightColor
                    : LightTheme.lightColor,
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
                            "${snap.totalPrice}€",
                            style: TextStyle(
                                color: Provider.of<ThemeProvider>(context)
                                        .isDarkMode
                                    ? DarkTheme.primaryColor
                                    : LightTheme.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          )
                        ]),
                    ElevatedButton(
                      // TODO: Add checkout page.
                      onPressed: () {},
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Provider.of<ThemeProvider>(context).isDarkMode
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
          );
        },
      ),
    );
  }

  Widget productCartList(BuildContext context) {
    ListView listView;
    return Consumer<CartProvider>(builder: (context, snapshot, child) {
      snapshot.loading = true;
      snapshot.cart.forEach((element) {
        listView = ListView.builder(
          itemBuilder: (_, index) => Container(
            height: 120,
            margin: EdgeInsets.all(5),
            child: Row(
              children: <Widget>[
                Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.all(10),
                    child: Image.asset(snapshot.cart[index].image,
                        fit: BoxFit.fitWidth)),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(snapshot.cart[index].name),
                      Text(
                        "${snapshot.cart[index].price}€",
                        style: TextStyle(
                            color:
                                Provider.of<ThemeProvider>(context).isDarkMode
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
                                color: Provider.of<ThemeProvider>(context)
                                        .isDarkMode
                                    ? DarkTheme.lightColor
                                    : LightTheme.lightColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: Row(
                              children: <Widget>[
                                Container(
                                    width: 40,
                                    alignment: Alignment.center,
                                    child: TextButton(
                                      child: Text("+",
                                          style: TextStyle(
                                              color: Provider.of<ThemeProvider>(
                                                          context)
                                                      .isDarkMode
                                                  ? DarkTheme.primaryColor
                                                  : LightTheme.primaryColor)),
                                      onPressed: () {
                                        snapshot
                                            .addProduct(snapshot.cart[index]);
                                      },
                                    )),
                                Container(
                                    width: 40,
                                    alignment: Alignment.center,
                                    child: Text(snapshot.cart[index].quantity
                                        .toString())),
                                Container(
                                    width: 20,
                                    alignment: Alignment.center,
                                    child: TextButton(
                                      child: Text(
                                        "-",
                                        style: TextStyle(
                                            color: Provider.of<ThemeProvider>(
                                                        context)
                                                    .isDarkMode
                                                ? DarkTheme.primaryColor
                                                : LightTheme.primaryColor),
                                      ),
                                      onPressed: () {
                                        snapshot.removeProduct(
                                            snapshot.cart[index], false);
                                      },
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              height: 39,
                              alignment: Alignment.center,
                              child: TextButton(
                                child: Icon(
                                  Icons.restore_from_trash,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  GetIt.I<CartProvider>().removeProduct(
                                      Product.productFromId(
                                          snapshot.cart[index].id),
                                      true);
                                  //ScaffoldMessenger.of(context).showSnackBar(
                                  //    SnackBar(content: Text("Removed from cart.")));
                                },
                              )),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          itemCount: snapshot.cart.length,
        );
      });
      snapshot.loading = false;
      return listView;
    });
  }

  emptyCart() {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.shopping_cart_sharp,
                color: Provider.of<ThemeProvider>(context).isDarkMode
                    ? DarkTheme.lightColor
                    : LightTheme.lightColor,
                size: 100),
            SizedBox(height: 20),
            Text(
              "Your cart is empty",
              style: TextStyle(
                  color: Provider.of<ThemeProvider>(context).isDarkMode
                      ? DarkTheme.reverseColor
                      : LightTheme.reverseColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ]),
    );
  }
}
