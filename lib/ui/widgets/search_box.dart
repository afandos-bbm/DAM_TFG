import 'package:cuevaDelRecambio/domain/services/providers/theme_provider.dart';
import 'package:cuevaDelRecambio/ui/themes/dark_theme.dart';
import 'package:cuevaDelRecambio/ui/themes/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class SearchBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: BorderSide(
          color: GetIt.I<ThemeProvider>().isDarkMode
              ? DarkTheme.primaryColor
              : LightTheme.primaryColor,
        ),
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Provider.of<ThemeProvider>(context).isDarkMode
              ? DarkTheme.lightColor
              : LightTheme.lightColor,
          borderRadius: BorderRadius.circular(30),
        ),
        height: 60,
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 10,
            ),
            Icon(Icons.search,
                color: Provider.of<ThemeProvider>(context).isDarkMode
                    ? DarkTheme.primaryColor
                    : LightTheme.primaryColor),
            Container(
              width: 270,
              padding: EdgeInsets.only(left: 10),
              child: TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                style: TextStyle(
                    fontSize: 20,
                    color: Provider.of<ThemeProvider>(context).isDarkMode
                        ? DarkTheme.primaryColor
                        : LightTheme.primaryColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
