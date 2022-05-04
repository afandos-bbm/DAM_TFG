import 'package:client_project/main.dart';
import 'package:client_project/themes/dark_theme.dart';
import 'package:client_project/themes/light_theme.dart';
import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final String text;
  final Image image;
  final double heightImage;
  final Function onPress;

  SocialButton({
    @required this.text,
    @required this.image,
    @required this.onPress,
    this.heightImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
          border: Border.all(color: MyApp.darkMode? DarkTheme.reverseColor:LightTheme.reverseColor, width: 0.5),
          borderRadius: BorderRadius.all(
            Radius.circular(4),
          )),
      child: TextButton(
        child: Row(
          children: <Widget>[
            Container(
              height: heightImage,
              width: 100,
              child: image,
            ),
            Text(text)
          ],
        ),
        onPressed: () {},
      ),
    );
  }
}
