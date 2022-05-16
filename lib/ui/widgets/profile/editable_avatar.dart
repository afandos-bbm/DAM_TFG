import 'package:client_project/domain/services/providers/theme_provider.dart';
import 'package:client_project/main.dart';
import 'package:client_project/ui/themes/dark_theme.dart';
import 'package:client_project/ui/themes/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final VoidCallback onClicked;

  const ProfileWidget({
    Key key,
    @required this.imagePath,
    @required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Provider.of<ThemeProvider>(context).isDarkMode
        ? DarkTheme.primaryColor
        : LightTheme.primaryColor;

    return Center(
      child: GestureDetector(
        onTap: onClicked,
        child: Stack(
          children: [
            buildImage(),
            Positioned(
              bottom: 0,
              right: 4,
              child: buildEditIcon(color),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildImage() {
    if (imagePath == null || imagePath.isEmpty || imagePath == "") {
      return Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey,
        ),
        child: Icon(
          Icons.person,
          size: 50,
          color: Colors.white,
        ),
      );
    }
    return CircleAvatar(
      radius: 50,
      backgroundImage: FadeInImage.assetNetwork(
        placeholder: 'assets/image-placeholder.png',
        image: imagePath,
        fit: BoxFit.cover,
      ).image,
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 8,
          child: Icon(
            Icons.edit,
            color: Colors.white,
            size: 20,
          ),
        ),
      );

  Widget buildCircle({
    @required Widget child,
    @required double all,
    @required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}
