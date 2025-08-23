import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';


class authService{
  final firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  User? get currentUser => firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();

  Future<UserCredential> signInWithEmailAndPassword ({
    required String email,
    required String password,

}) async {
    return await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password);
  }

  Future<UserCredential> createUser ({
    required String email,
  required String password,
    required String confirmPassword
  }) async {

    return await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
        );
  }

  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }

  Future<void> resetPassword({
    required String email
}) async {
    return await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  Future<void> resetPasswordFromCurrentPassword({
    required String currentPassword,
    required String newPassword,
    required String email
}) async{
    AuthCredential credential =
        EmailAuthProvider.credential(email: email, password: currentPassword);
    await currentUser!.reauthenticateWithCredential(credential);
    await currentUser!.updatePassword(newPassword);
  }

  Future<UserCredential?> signInWithGoogle()
  async {

    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {

        return null;
      }
      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
      );
      final userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);
      return userCredential;
    } catch (e) {


    }
  }
}