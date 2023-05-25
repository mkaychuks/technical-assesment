// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intern/screens/screens.dart';
import 'package:intern/widgets/snackbar.dart';

class AuthenticationMethods {
  final FirebaseAuth _auth;
  AuthenticationMethods(
    this._auth,
  );

  // sign up user with email and password
  Future signUpUserWithEmailAndPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (context.mounted) {
        Navigator.of(context).pushReplacement(CupertinoPageRoute(
          builder: (context) => const MedicineHomePage(),
        ));
      }
    } on FirebaseAuthException catch (_) {
      showSnackBar(
          color: Colors.red,
          text: "user credentials already exists",
          context: context);
    } on SocketException {
      showSnackBar(
          color: Colors.red,
          text: "Internet connection not stabe",
          context: context);
    }
  }

  // sign_out
  Future<void> signOut(BuildContext context) async {
    await _auth.signOut();
    if (context.mounted) {
      Navigator.of(context).pushReplacement(CupertinoPageRoute(
        builder: (context) => const RegisterScreen(),
      ));
    }
  }

  // google sign in
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
        final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

        await _auth.signInWithCredential(credential);
        if (context.mounted) {
          Navigator.of(context).pushReplacement(CupertinoPageRoute(
            builder: (context) => const MedicineHomePage(),
          ));
        }
      }
    } on FirebaseAuthException catch (_) {
      showSnackBar(
          context: context, text: "Something went wrong", color: Colors.red);
    } on SocketException {
      showSnackBar(context: context, text: "Internet lost", color: Colors.red);
    }
  }
}
