import 'package:client_project/domain/services/providers/theme_provider.dart';
import 'package:client_project/main.dart';
import 'package:client_project/ui/pages/home/profile/about_page.dart';
import 'package:client_project/ui/pages/home/profile/edit_profile_page.dart';
import 'package:client_project/ui/pages/home/profile/notifications_page.dart';
import 'package:client_project/ui/pages/home/profile/settings_page.dart';
import 'package:client_project/ui/widgets/profile/editable_avatar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class UserPage extends StatefulWidget {
  UserPage({Key key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  User user = GetIt.I<FirebaseAuth>().currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 20),
          ProfileWidget(
            imagePath: user.photoURL ?? "",
            onClicked: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EditProfilePage(),
                ),
              );
            },
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
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(height: 16),
        Card(
          child: ListTile(
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.settings),
            ),
            title: Text('Settings (Soon)'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SettingsPage(),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: ListTile(
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.notifications),
            ),
            title: Text('Notifications (Soon)'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => NotificationsPage(),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: ListTile(
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.help),
            ),
            title: Text('About (Soon)'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AboutPage(),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    Provider.of<ThemeProvider>(context).isDarkMode
                        ? Color(Colors.red.value)
                        : Color(Colors.red.value))),
            onPressed: () async {
              await FirebaseAuth.instance.signOut().then((value) =>
                  Navigator.of(context).pushReplacementNamed("/login"));
            },
            child: Text("Sign Out"),
          ),
        ),
      ]));
}
