import 'package:client_project/pages/login.page.dart';
import 'package:client_project/pages/tabs.page.dart';
import 'package:client_project/providers/cart_provider.dart';
import 'package:client_project/themes/dark_theme.dart';
import 'package:client_project/themes/light_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/widgets.dart' show WidgetsFlutterBinding;
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MyApp.marcasJson = await MyApp.loadJson();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final User _user = FirebaseAuth.instance.currentUser;
  static String marcasJson;

  static get darkMode => _darkMode;
  static bool _darkMode = false;

  static Future<String> loadJson() async {
    await wait(3);
    return await rootBundle.loadString('json/marcas.json');
  }

  static Future wait(int seconds) {
    return new Future.delayed(Duration(seconds: seconds), () => {});
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CartProvider>(
            create: (context) => CartProvider()),
      ],
      child: MaterialApp(
        routes: {
          "/login": (context) => LoginPage(),
          "/home": (context) => TabsPage(),
        },
        debugShowCheckedModeBanner: false,
        title: 'La Cueva del Recambio',
        theme:
            _darkMode ? DarkTheme.getDarkTheme() : LightTheme.getLightTheme(),
        home: DefaultTabController(
          length: 3,
          child: _user == null ? LoginPage() : TabsPage(),
        ),
      ),
    );
  }
}
