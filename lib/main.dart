import 'package:client_project/domain/services/providers/cart_provider.dart';
import 'package:client_project/ui/pages/home/tabs_page.dart';
import 'package:client_project/ui/pages/login/login_page.dart';
import 'package:client_project/ui/themes/dark_theme.dart';
import 'package:client_project/ui/themes/light_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'di.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await MyApp.loadJson();
  await di.init();
  GetIt.I<FirebaseAuth>().authStateChanges().listen((user) {
    if (user != null && !(GetIt.I.isRegistered<CartProvider>())) {
      di.registerCartProvider();
    } else {
      if (GetIt.I.isRegistered<CartProvider>()) di.unRegisterCartProvider();
    }
  });
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static String marcasJson;
  static String productsJson;

  static get darkMode => _darkMode;
  static changeDarkMode() => _darkMode = !_darkMode;

  static bool _darkMode = true;

  static Future<void> loadJson() async {
    await wait(3);
    productsJson = await rootBundle.loadString('json/productos.json');
    marcasJson = await rootBundle.loadString('json/marcas.json');
  }

  static Future wait(int seconds) {
    return new Future.delayed(Duration(seconds: seconds), () => {});
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final User _user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CartProvider>(
            create: (context) => GetIt.I.get()),
      ],
      child: MaterialApp(
        routes: {
          "/login": (context) => LoginPage(),
          "/home": (context) => TabsPage(),
        },
        debugShowCheckedModeBanner: false,
        title: 'La Cueva del Recambio',
        theme: MyApp._darkMode
            ? DarkTheme.getDarkTheme()
            : LightTheme.getLightTheme(),
        home: DefaultTabController(
          length: 3,
          child: _user == null ? LoginPage() : TabsPage(),
        ),
      ),
    );
  }
}
