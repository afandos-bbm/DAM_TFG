import 'package:client_project/main.dart';
import 'package:client_project/themes/dark_theme.dart';
import 'package:client_project/themes/light_theme.dart';
import 'package:client_project/widgets/auth_service.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyApp.darkMode
            ? DarkTheme.backgroundColor
            : LightTheme.backgroundColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: MyApp.darkMode
              ? DarkTheme.backgroundColor
              : LightTheme.backgroundColor,
        ),
        body: SingleChildScrollView(
          child: Container(
            color: MyApp.darkMode
                ? DarkTheme.backgroundColor
                : LightTheme.backgroundColor,
            padding: EdgeInsets.only(
              top: 10,
              left: 20,
              right: 20,
              bottom: 40,
            ),
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: MyApp.darkMode
                          ? DarkTheme.backgroundColor
                          : LightTheme.backgroundColor,
                      boxShadow: [
                        BoxShadow(
                            color: MyApp.darkMode
                                ? DarkTheme.reverseColor
                                : LightTheme.reverseColor,
                            offset: Offset(1, 2.0),
                            blurRadius: 5,
                            spreadRadius: 1)
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
                        Text(
                          "Sign Up",
                          style: TextStyle(
                              fontSize: 30.0, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: _nameController,
                          autofocus: true,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              labelText: "Name",
                              labelStyle: TextStyle(
                                color: MyApp.darkMode
                                    ? DarkTheme.reverseColor
                                    : LightTheme.reverseColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              )),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _emailController,
                          autofocus: true,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              labelText: "Email",
                              labelStyle: TextStyle(
                                color: MyApp.darkMode
                                    ? DarkTheme.reverseColor
                                    : LightTheme.reverseColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              )),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          autofocus: true,
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              labelText: "Password",
                              labelStyle: TextStyle(
                                color: MyApp.darkMode
                                    ? DarkTheme.reverseColor
                                    : LightTheme.reverseColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              )),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                            decoration: BoxDecoration(
                                color: MyApp.darkMode
                                    ? DarkTheme.primaryColor
                                    : LightTheme.primaryColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            width: MediaQuery.of(context).size.width,
                            child: TextButton(
                              child: Text(
                                "Signup",
                                style: TextStyle(
                                    color: MyApp.darkMode
                                        ? DarkTheme.backgroundColor
                                        : LightTheme.backgroundColor),
                              ),
                              onPressed: () async {
                                if (await register(
                                    context,
                                    _nameController.text,
                                    _emailController.text,
                                    _passwordController.text)) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("Registered.")));
                                  Navigator.of(context).pushNamed("/home");
                                }
                              },
                            ))
                      ]),
                ),
              ],
            ),
          ),
        ));
  }
}
