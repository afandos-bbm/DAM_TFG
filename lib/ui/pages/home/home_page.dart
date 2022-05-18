import 'package:cuevaDelRecambio/domain/services/providers/theme_provider.dart';
import 'package:cuevaDelRecambio/ui/themes/dark_theme.dart';
import 'package:cuevaDelRecambio/ui/themes/light_theme.dart';
import 'package:cuevaDelRecambio/ui/widgets/category/category_list.dart';
import 'package:cuevaDelRecambio/ui/widgets/product/product_list.dart';
import 'package:cuevaDelRecambio/ui/widgets/search_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Provider.of<ThemeProvider>(context).isDarkMode
          ? DarkTheme.backgroundColor
          : LightTheme.backgroundColor,
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(20),
            width: double.infinity,
            color: Provider.of<ThemeProvider>(context).isDarkMode
                ? DarkTheme.backgroundColor
                : LightTheme.backgroundColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 40,
                ),
                SearchBox(),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Categories",
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(
                  height: 10,
                ),
                CategoryList(),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Catalogue",
                      style: TextStyle(fontSize: 30),
                    ),
                    // TextButton(
                    //   onPressed: () {},
                    //   child: Text("See all"),
                    // )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 320,
                  child: ProductList(),
                ),
              ],
            )),
      ),
    );
  }
}
