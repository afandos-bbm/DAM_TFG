import 'package:client_project/domain/entities/producto.dart';
import 'package:client_project/domain/services/providers/cart_provider.dart';
import 'package:client_project/main.dart';
import 'package:client_project/ui/themes/dark_theme.dart';
import 'package:client_project/ui/themes/light_theme.dart';
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
            Producto producto = Producto.productoFromId(id);
            cartProvider.addProduct(producto);
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
