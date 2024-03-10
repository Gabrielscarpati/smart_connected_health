import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import '../../widgets/widgets.dart';

class TextFieldsLogIn extends StatefulWidget {
  const TextFieldsLogIn({Key? key}) : super(key: key);

  @override
  State<TextFieldsLogIn> createState() => _TextFieldsLogInState();
}

class _TextFieldsLogInState extends State<TextFieldsLogIn> {
  @override
  Widget build(BuildContext context) {
    TextEditingController signUpEmail = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    String? validateEmailSignUp(String? value) {
      String email = signUpEmail.text.trim();
      if (!EmailValidator.validate(email)) {
        return "Enter a valid Email";
      } else {
        return null;
      }
    }

    String? validatePasswordSignUp(String? password) {
      if (password == null || password.length < 6) {
        return "Password must contain at least 6 characters";
      } else {
        return null;
      }
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextFieldLogInSignUp(
          title: 'Email',
          hint: 'Email',
          texFieldController: signUpEmail,
          validator: validateEmailSignUp,
          prefixIcon: Icons.email_outlined,
          suffixIcon: Icons.close,
          deleteOrHide: 'delete',
        ),
        TextFieldLogInSignUp(
          title: 'Password',
          hint: 'Enter Password',
          texFieldController: passwordController,
          validator: validatePasswordSignUp,
          prefixIcon: Icons.lock_outline,
          suffixIcon: Icons.close,
          deleteOrHide: 'hide',
        ),
      ],
    );
  }
}
