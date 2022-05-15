import 'package:client_project/domain/services/providers/theme_provider.dart';
import 'package:client_project/main.dart';
import 'package:client_project/ui/themes/dark_theme.dart';
import 'package:client_project/ui/themes/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryItem extends StatelessWidget {
  final Image image;

  CategoryItem({@required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Provider.of<ThemeProvider>(context).isDarkMode
                  ? DarkTheme.primaryColor
                  : LightTheme.primaryColor,
              offset: Offset(0, 0),
              blurRadius: 5,
              spreadRadius: 2,
            )
          ],
          borderRadius: BorderRadius.all(Radius.circular(64))),
      child: image,
    );
  }
}
