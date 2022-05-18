import 'package:client_project/domain/services/providers/theme_provider.dart';
import 'package:client_project/ui/pages/product_page.dart';
import 'package:client_project/ui/themes/dark_theme.dart';
import 'package:client_project/ui/themes/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:client_project/main.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  final String id;
  final String image;
  final String name;
  final String description;
  final String brand;
  final double price;
  final List<String> tags;

  ProductCard(
      {@required this.image,
      @required this.name,
      @required this.id,
      @required this.brand,
      @required this.price,
      @required this.tags,
      @required this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        clipBehavior: Clip.none,
        width: 170,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(right: 12, top: 1, bottom: 1, left: 1),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => ProductPage(
                              id: id,
                              image: image,
                              title: name,
                              brand: brand,
                              description: description,
                              price: price,
                              tags: tags,
                            )));
              },
              child: Container(
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              name,
              style: TextStyle(
                  fontSize: 16,
                  color: Provider.of<ThemeProvider>(context).isDarkMode
                      ? DarkTheme.reverseColor
                      : LightTheme.reverseColor,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              brand,
              style: TextStyle(
                fontSize: 14,
                color: Provider.of<ThemeProvider>(context).isDarkMode
                    ? DarkTheme.reverseColor
                    : LightTheme.reverseColor,
              ),
            ),
            Text(
              "\$ $price",
              style: TextStyle(
                  fontSize: 14,
                  color: Provider.of<ThemeProvider>(context).isDarkMode
                      ? DarkTheme.primaryColor
                      : LightTheme.primaryColor,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
