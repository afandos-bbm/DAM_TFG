import 'package:client_project/main.dart';
import 'package:client_project/themes/dark_theme.dart';
import 'package:client_project/themes/light_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  UserPage({Key key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  User user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyApp.darkMode
            ? DarkTheme.backgroundColor
            : LightTheme.backgroundColor,
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.person_rounded,
              size: 50,
            ),
            SizedBox(
              height: 20,
            ),
            Text("Welcome, ${user.displayName}"),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(MyApp.darkMode
                        ? DarkTheme.primaryColor
                        : LightTheme.primaryColor)),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut().then(
                      (value) => Navigator.of(context).pushNamed("/login"));
                },
                child: Text("Sign Out")),
          ],
        )));
  }
}
