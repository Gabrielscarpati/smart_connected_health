import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import '../data/firebase_manager.dart';
import '../data/sign_up_user.dart';
import '../data/user_entity.dart';

class LogInSignUpProvider with ChangeNotifier {
  static final LogInSignUpProvider provider = LogInSignUpProvider._internal();

  factory LogInSignUpProvider() {
    return provider;
  }
  LogInSignUpProvider._internal();
  FirebaseManager firebaseManager = FirebaseManager();

  GlobalKey<FormState> formKeyAuthenticationSignUp = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyAuthenticationLogIn = GlobalKey<FormState>();

  GlobalKey<FormState> formKeyAuthenticationResetPassword =
      GlobalKey<FormState>();

  TextEditingController signUpEmail = TextEditingController();
  TextEditingController signUpFirstName = TextEditingController();
  TextEditingController signUpLastName = TextEditingController();
  TextEditingController signUpPassword = TextEditingController();
  TextEditingController signUpConfirmPassword = TextEditingController();

  TextEditingController logInPassword = TextEditingController();
  TextEditingController logInEmail = TextEditingController();

  TextEditingController resetPasswordEmail = TextEditingController();
  bool loading = false;

  bool isCheckedRememberMe = false;

  void updateIsCheckedRememberMe() {
    isCheckedRememberMe = !isCheckedRememberMe;
  }

  void updateLoading(bool loading) {
    this.loading = loading;
    notifyListeners();
  }

  String? validateEmailSignUp(String? value) {
    String email = signUpEmail.text.trim();
    if (!EmailValidator.validate(email)) {
      return "Enter a valid Email";
    } else {
      return null;
    }
  }

  String? validatePasswordSignUp(String? value) {
    bool regExp = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$')
        .hasMatch(signUpPassword.text.trim());
    if (!regExp) {
      return "Your password must contain at least 6 characters,\n including upper and lower case letters and numbers.";
    } else {
      return null;
    }
  }

  String? validateConfirmPassword(String? value) {
    if (signUpConfirmPassword.text.trim() != signUpPassword.text.trim()) {
      return "Passwords don't match";
    } else {
      return null;
    }
  }

  String? validateEmailLogIn(String? value) {
    String email = logInEmail.text.trim();
    if (!EmailValidator.validate(email)) {
      return "Enter a valid Email";
    } else {
      return null;
    }
  }

  String? validatePasswordLogIn(String? value) {
    bool regExp = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$')
        .hasMatch(logInPassword.text.trim());
    if (!regExp) {
      return "Your password must contain at least 6 characters,\n including upper and lower case letters and numbers.";
    } else {
      return null;
    }
  }

  String? validateEmailResetPassword(String? value) {
    String email = resetPasswordEmail.text.trim();
    if (!EmailValidator.validate(email)) {
      return "Enter a valid Email";
    } else {
      return null;
    }
  }

  Future<void> signupUser({required String? userId}) async {
    UserEntity new_user = UserEntity(
      id: userId!,
      email: signUpEmail.text.trim(),
      firstName: signUpFirstName.text.trim(),
      lastName: signUpLastName.text.trim(),
    );

    await UserController().signUpUser(new_user);

    notifyListeners();
  }

  Future<void> checkConditionsLogInUser(BuildContext context) async {
    try {
      final formLogIn = formKeyAuthenticationLogIn.currentState!;
      if (formLogIn.validate()) {
        await firebaseManager.loginUser(
          email: logInEmail.text.trim(),
          password: logInPassword.text.trim(),
          context: context,
        );
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> checkConditionsSignUpUser(BuildContext context) async {
    {
      await firebaseManager.registerUser(
        email: signUpEmail.text.trim(),
        password: signUpPassword.text.trim(),
        context: context,
      );
      await signupUser(
        userId: await firebaseManager.getUserCurrentID(),
      );
      notifyListeners();
    }
  }

  String userFirstName = '';
  Future<String> getFirstNameByUserId(String userId) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      DocumentSnapshot userDoc =
          await firestore.collection('users').doc(userId).get();

      if (userDoc.exists && userDoc.data() != null) {
        String firstName =
            (userDoc.data() as Map<String, dynamic>)['firstName'];
        return firstName;
      } else {
        throw Exception('User not found or no data available.');
      }
    } catch (e) {
      print('Error getting user: $e');
      throw e;
    }
  }
}
