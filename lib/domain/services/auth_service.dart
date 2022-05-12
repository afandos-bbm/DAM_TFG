import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

Future<bool> loginWithGoogle(BuildContext context) async {
  try {
    FirebaseAuth auth = FirebaseAuth.instance;

    final GoogleSignInAccount googleSignInAccount =
        await GoogleSignIn().signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        await auth.signInWithCredential(credential);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("You have signed up with a different account.")));
          return false;
        } else if (e.code == 'invalid-credential') {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Invalid credential.")));
          return false;
        }
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("An error occurred.")));
        return false;
      }
      return true;
    }
    return false;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'account-exists-with-different-credential')
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Try using a different email.")));
    else if (e.code == 'invalid-credential')
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Invalid email or password.")));
    return false;
  }
}

// Implement login with facebook
Future<bool> loginWithFacebook(BuildContext context) async {
  try {
    FirebaseAuth auth = FirebaseAuth.instance;

    FacebookAuth instance = FacebookAuth.instance;

    final LoginResult result = await instance.login();

    if (result.status == LoginStatus.success) {
      final AuthCredential credential =
          FacebookAuthProvider.credential(result.accessToken.token);
      try {
        await auth.signInWithCredential(credential);
        if (auth.currentUser != null) {
          return true;
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("You have signed up with a different account.")));
          return false;
        } else if (e.code == 'invalid-credential') {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Invalid credential.")));
          return false;
        }
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("An error occurred.")));
        return false;
      }
    }
  } catch (e) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("An error occurred.")));
    return false;
  }
  return false;
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
