import 'package:client_project/domain/services/providers/theme_provider.dart';
import 'package:client_project/main.dart';
import 'package:client_project/ui/themes/dark_theme.dart';
import 'package:client_project/ui/themes/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Provider.of<ThemeProvider>(context).isDarkMode
              ? DarkTheme.primaryColor
              : LightTheme.primaryColor,
        ),
        color: Provider.of<ThemeProvider>(context).isDarkMode
            ? DarkTheme.lightColor
            : LightTheme.lightColor,
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      height: 60,
      child: Row(
        children: <Widget>[
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
    );
  }
}
