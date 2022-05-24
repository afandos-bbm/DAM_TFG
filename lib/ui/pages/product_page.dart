import 'package:cuevaDelRecambio/domain/entities/product.dart';
import 'package:cuevaDelRecambio/domain/services/providers/cart_provider.dart';
import 'package:cuevaDelRecambio/domain/services/providers/theme_provider.dart';
import 'package:cuevaDelRecambio/ui/themes/dark_theme.dart';
import 'package:cuevaDelRecambio/ui/themes/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatelessWidget {
  final String id;
  final String image;
  final String title;
  final String description;
  final String brand;
  final double price;
  final List<String> tags;

  ProductPage(
      {@required this.image,
      @required this.id,
      @required this.title,
      @required this.brand,
      @required this.price,
      @required this.tags,
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
            final cartProvider = GetIt.I<CartProvider>();
            Product producto = Product.productFromId(id);
            cartProvider.addProduct(producto);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Added to cart"),
            ));
          },
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  Provider.of<ThemeProvider>(context).isDarkMode
                      ? DarkTheme.primaryColor
                      : LightTheme.primaryColor)),
          child: Icon(Icons.add_shopping_cart),
        ));
  }
}
