import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';


class authService{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'profile',
    ],
  );

  User? get currentUser => firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();

  Future<void> signUp ({
    required String email,
    required String password,
    required String confirmPassword

}) async {
    try {
      if (password != confirmPassword) {
        throw Exception('Password tidak cocok');
      }
      UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      User? user = userCredential.user;

      if (user != null) {
        await _firestore.collection('user').doc(userCredential.user!.uid).set({
          'id': user.uid,
          'email': user.email,
        });
      }
    } catch(e){
      rethrow;
    }
  }


  Future<UserCredential> signIn ({
    required String email,
    required String password,
  }) async {
    return await FirebaseAuth.instance.signInWithEmailAndPassword(
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

  Future<void> signInWithGoogle()
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
        idToken: googleAuth.idToken
      );
      final userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

      User? user = userCredential.user;

      if (user != null) {
        await _firestore.collection('user').doc(userCredential.user!.uid).set({
          'id': user.uid,
          'email': user.email ?? googleUser.email,
        }, SetOptions(merge: true)
        );
      }
    } catch (e) {

    }
  }


  Future<void> signOutGoogle() async {
    await googleSignIn.signOut();
  }
}