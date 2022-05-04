import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<bool> login(BuildContext context, String email, String password) async {
  try {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password')
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Try using a strong password.")));
    else if (e.code == 'email-already-in-use')
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("That email is in use yet.")));
    return false;
  }
}

Future<bool> register(
    BuildContext context, String name, String email, String password) async {
  try {
    User user = (await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password))
        .user;
    await user.updateDisplayName(name);

    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password')
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Try using a strong password.")));
    else if (e.code == 'email-already-in-use')
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("That email is in use yet.")));
    return false;
  }
}