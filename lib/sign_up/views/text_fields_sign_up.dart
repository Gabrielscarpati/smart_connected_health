import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import '../../widgets/widgets.dart';

class TextFieldsSignUp extends StatefulWidget {
  const TextFieldsSignUp({Key? key}) : super(key: key);

  @override
  State<TextFieldsSignUp> createState() => _TextFieldsSignUpState();
}

class _TextFieldsSignUpState extends State<TextFieldsSignUp> {
  TextEditingController signUpEmail = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  String? validatePasswordSignUp(String? password) {
    if (password == null || password.length < 6) {
      return "Password must contain at least 6 characters";
    } else {
      return null;
    }
  }

  String? validateEmailSignUp(String? value) {
    String email = signUpEmail.text.trim();
    if (!EmailValidator.validate(email)) {
      return "Enter a valid Email";
    } else {
      return null;
    }
  }

  String? confirmPassword(String? value) {
    if (passwordController.text != confirmPasswordController.text) {
      return "Passwords do not match";
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFieldLogInSignUp(
          title: 'Email',
          hint: 'Email',
          texFieldController: signUpEmail,
          validator: validateEmailSignUp,
          prefixIcon: Icons.email,
          suffixIcon: Icons.close,
          deleteOrHide: 'delete',
        ),
        TextFieldLogInSignUp(
          title: 'Password',
          hint: 'Password',
          texFieldController: passwordController,
          validator: validatePasswordSignUp,
          prefixIcon: Icons.lock,
          suffixIcon: Icons.close,
          deleteOrHide: 'hide',
        ),
        TextFieldLogInSignUp(
          title: 'Confirm Password',
          hint: 'Confirm Password',
          texFieldController: confirmPasswordController,
          validator: confirmPassword,
          prefixIcon: Icons.lock_reset,
          suffixIcon: Icons.close,
          deleteOrHide: 'hide',
        ),
      ],
    );
  }
}
