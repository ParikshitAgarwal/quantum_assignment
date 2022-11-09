import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quantum_assignment/screens/authentication/auth_screen.dart';
import 'package:quantum_assignment/screens/home/home_screen.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth;
  FirebaseAuthMethods(this._auth);

  //SIGN UP
  Future<void> signUpWithEmail(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: ((context) => HomeScreen())));
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  //EMAIL LOGIN
  Future<void> loginWithEmail(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: ((context) => HomeScreen())));
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  //Google Sign In
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      print("You are logged in");
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: ((context) => HomeScreen())));
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  //Sign Out
  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => AuthScreen()));
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  void showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }
}
