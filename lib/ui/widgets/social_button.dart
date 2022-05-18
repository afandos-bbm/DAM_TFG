import 'package:client_project/domain/services/providers/theme_provider.dart';
import 'package:client_project/main.dart';
import 'package:client_project/ui/themes/dark_theme.dart';
import 'package:client_project/ui/themes/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    return Card(
      child: Container(
        height: 60,
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
          onPressed: onPress,
        ),
      ),
    );
  }
}
