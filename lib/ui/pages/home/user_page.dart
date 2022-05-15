import 'package:client_project/main.dart';
import 'package:client_project/ui/themes/dark_theme.dart';
import 'package:client_project/ui/themes/light_theme.dart';
import 'package:client_project/ui/widgets/profile/editable_avatar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class UserPage extends StatefulWidget {
  UserPage({Key key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  User user = GetIt.I<FirebaseAuth>().currentUser;

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //     backgroundColor: MyApp.darkMode
    //         ? DarkTheme.backgroundColor
    //         : LightTheme.backgroundColor,
    //     body: Center(
    //         child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: <Widget>[
    //         Icon(
    //           Icons.person_rounded,
    //           size: 50,
    //         ),
    //         SizedBox(
    //           height: 20,
    //         ),
    //         Text("Welcome, ${user.displayName}"),
    //         SizedBox(
    //           height: 20,
    //         ),
    //         ElevatedButton(
    //             style: ButtonStyle(
    //                 backgroundColor: MaterialStateProperty.all(MyApp.darkMode
    //                     ? DarkTheme.primaryColor
    //                     : LightTheme.primaryColor)),
    //             onPressed: () async {
    //               await FirebaseAuth.instance.signOut().then(
    //                   (value) => Navigator.of(context).pushNamed("/login"));
    //             },
    //             child: Text("Sign Out")),
    //       ],
    //     )));
    print(user.photoURL);
    return Scaffold(
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 20),
          ProfileWidget(
            imagePath: user.photoURL ?? "",
            onClicked: () async {},
          ),
          const SizedBox(height: 24),
          buildName(user),
          const SizedBox(height: 24),
          Center(child: buildSetCar()),
          const SizedBox(height: 24),
          Divider(
            thickness: 2,
            height: 1,
            indent: 10.0,
            endIndent: 10.0,
          ),
          const SizedBox(height: 48),
          buildConfig(user),
        ],
      ),
    );
  }

  Widget buildName(User user) => Column(
        children: [
          Text(
            user.displayName,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            user.email,
            style: TextStyle(color: Colors.grey),
          )
        ],
      );

  Widget buildSetCar() => ElevatedButton(
        child: Text('Choose a car (soon)'),
        onPressed: () {},
      );

  Widget buildConfig(User user) => Container(
      padding: EdgeInsets.symmetric(horizontal: 48),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 16),
            Text(
              "Config (Soon)",
              style: TextStyle(fontSize: 16, height: 1.4),
            ),

            // Create a button to change the theme of the app
            const SizedBox(height: 16),
            Text(
              "Theme",
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Dark Mode",
                  style: TextStyle(fontSize: 16),
                ),
                Switch(
                  value: MyApp.darkMode,
                  onChanged: (value) {
                    setState(() {
                      MyApp.changeDarkMode();
                    });
                  },
                ),
              ],
            ),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(MyApp.darkMode
                        ? Color(Colors.red.value)
                        : Color(Colors.red.value))),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut().then(
                      (value) => Navigator.of(context).pushNamed("/login"));
                },
                child: Text("Sign Out")),
          ]));
}
