import 'package:client_project/domain/services/auth_service.dart';
import 'package:client_project/domain/services/providers/theme_provider.dart';
import 'package:client_project/ui/pages/login/register_page.dart';
import 'package:client_project/ui/themes/dark_theme.dart';
import 'package:client_project/ui/themes/light_theme.dart';
import 'package:client_project/ui/widgets/social_button.dart';
import 'package:flutter/material.dart';
import 'package:client_project/main.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Provider.of<ThemeProvider>(context).isDarkMode
            ? DarkTheme.backgroundColor
            : LightTheme.backgroundColor,
        body: SingleChildScrollView(
          child: Container(
            color: Provider.of<ThemeProvider>(context).isDarkMode
                ? DarkTheme.backgroundColor
                : LightTheme.backgroundColor,
            padding: EdgeInsets.only(
              top: 80,
              left: 20,
              right: 20,
              bottom: 40,
            ),
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: Provider.of<ThemeProvider>(context).isDarkMode
                          ? DarkTheme.backgroundColor
                          : LightTheme.backgroundColor,
                      boxShadow: [
                        BoxShadow(
                            color:
                                Provider.of<ThemeProvider>(context).isDarkMode
                                    ? DarkTheme.lightColor
                                    : LightTheme.lightColor,
                            offset: Offset(0, 0),
                            blurRadius: 4,
                            spreadRadius: 2)
                      ]),
                  height: 400,
                  padding: EdgeInsets.only(
                    top: 38,
                    left: 20,
                    right: 20,
                    bottom: 20,
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Text(
                                  "Welcome,",
                                  style: TextStyle(
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.w500),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 10,
                                  ),
                                  child: Text(
                                    "Signin in to continue",
                                    style: TextStyle(
                                      fontSize: 13.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            TextButton(
                              child: Text("Sign Up"),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        fullscreenDialog: true,
                                        builder: (context) => SignupPage()));
                              },
                            )
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        TextFormField(
                          controller: _emailController,
                          autofocus: false,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              labelText: "Email",
                              labelStyle: TextStyle(
                                color: Provider.of<ThemeProvider>(context)
                                        .isDarkMode
                                    ? DarkTheme.lightColor
                                    : LightTheme.lightColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              )),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          autofocus: false,
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              labelText: "Password",
                              labelStyle: TextStyle(
                                color: Provider.of<ThemeProvider>(context)
                                        .isDarkMode
                                    ? DarkTheme.lightColor
                                    : LightTheme.lightColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              )),
                        ),
                        Container(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              child: Text("Forgot your password?"),
                              onPressed: () {},
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            decoration: BoxDecoration(
                                color: Provider.of<ThemeProvider>(context)
                                        .isDarkMode
                                    ? DarkTheme.primaryColor
                                    : LightTheme.primaryColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            width: MediaQuery.of(context).size.width,
                            child: TextButton(
                              child: Text(
                                "Login",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () async => await login(
                                      context,
                                      _emailController.text,
                                      _passwordController.text)
                                  ? Navigator.of(context)
                                      .pushReplacementNamed("/home")
                                  : ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("Login failed"))),
                            ))
                      ]),
                ),
                Container(
                  padding: EdgeInsets.only(top: 20, bottom: 15),
                  child: Text(
                    "- OR -",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                  ),
                ),
                SocialButton(
                  text: "Login In with Facebook",
                  image: Image.asset("assets/facebook.png"),
                  heightImage: 24,
                  onPress: () async {
                    await loginWithFacebook(context)
                        ? Navigator.of(context).pushReplacementNamed("/home")
                        : ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Login failed")));
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                SocialButton(
                  text: "Login In with Google",
                  image: Image.asset("assets/google.png"),
                  heightImage: 24,
                  onPress: () async {
                    await loginWithGoogle(context)
                        ? Navigator.of(context).pushReplacementNamed("/home")
                        : ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Login fail.")));
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
