import 'package:client_project/domain/services/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 65),
            Text(
              'Settings',
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(height: 24),
            Card(
              child: ListTile(
                title: Text("App Theme"),
                subtitle: Text("Dark/Light"),
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.brightness_4),
                ),
                trailing: Switch(
                  value: Provider.of<ThemeProvider>(context).isDarkMode,
                  onChanged: (value) {
                    Provider.of<ThemeProvider>(context, listen: false)
                        .changeTheme();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
