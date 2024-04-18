import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../design_system/snack_back.dart';

class FirebaseManager {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<String?> getUserCurrentID() async {
    if (firebaseAuth.currentUser != null) {
      return firebaseAuth.currentUser!.uid;
    } else {
      return null;
    }
  }

  Future<User?> registerUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      print('registerUser');
      print('email: $email');
      print('password: $password');
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        ShowSnackBar(context: context)
            .showErrorSnackBar(message: 'Email already in use');
      }
    }
    return null;
  }

  Future<User?> loginUser(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        return userCredential.user;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ShowSnackBar(context: context)
            .showErrorSnackBar(message: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        ShowSnackBar(context: context).showErrorSnackBar(
            message: 'Wrong password provided for that user.');
      } else if (e.code == 'too-many-requests') {
        ShowSnackBar(context: context).showErrorSnackBar(
            message: 'Too many requests, please try again later.');
      }
    }
    return null;
  }

  Future signOut({required BuildContext context}) async {
    try {
      return await firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      ShowSnackBar(context: context)
          .showErrorSnackBar(message: e.code.toString());
      return null;
    }
  }

  Future resetPassword(
      {required String email, required BuildContext context}) async {
    bool doesEmailExists = await checkIfEmailInUse(email);
    if (!doesEmailExists) {
      ShowSnackBar(context: context)
          .showErrorSnackBar(message: 'This email is not registered.');
    } else {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    }
  }

  Future<bool> checkIfEmailInUse(String emailAddress) async {
    try {
      List<String> list =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(emailAddress);
      if (list.isEmpty) {
        return false;
      } else {
        return true;
      }
    } catch (error) {
      return true;
    }
  }
}
