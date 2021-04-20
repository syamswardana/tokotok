import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static GoogleSignIn _googleSignIn = GoogleSignIn.standard();

  static Stream<User> get firebaseUserStream {
    return _auth.authStateChanges();
  }

  static Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    GoogleSignInAccount googleUser;
    try {
      googleUser = await _googleSignIn.signIn();
    } catch (error) {
      print(error.message);
    }

    // Return null to prevent further exceptions if googleSignInAccount is null
    if (googleUser == null) return null;
    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await _auth.signInWithCredential(credential);
  }

  static Future<UserCredential> signUpEmail(
      {@required String email,
      @required String password,
      @required BuildContext context}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } catch (e) {
      String msg = "Error";
      if (e.code == 'user-not-found') {
        msg = "User tidak ditemukan";
      } else if (e.code == 'wrong-password') {
        msg = "Password tidak cocok";
      } else if (e.code == 'invalid-email') {
        msg = "Format email salah";
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    }
    return null;
  }

  static Future<UserCredential> signInEmail(
      {@required String email,
      @required String password,
      @required BuildContext context}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      String msg = "Error";
      if (e.code == 'user-not-found') {
        msg = "User tidak ditemukan";
      } else if (e.code == 'wrong-password') {
        msg = "Password tidak cocok";
      } else if (e.code == 'invalid-email') {
        msg = "Format email salah";
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    }
    return null;
  }

  static signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  static Future<User> getCurrentUser() async {
    return _auth.currentUser;
  }
}
