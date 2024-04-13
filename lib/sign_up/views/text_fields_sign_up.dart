import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/user_provider.dart';
import '../../widgets/widgets.dart';

class TextFieldsSignUp extends StatefulWidget {
  const TextFieldsSignUp({Key? key}) : super(key: key);

  @override
  State<TextFieldsSignUp> createState() => _TextFieldsSignUpState();
}

class _TextFieldsSignUpState extends State<TextFieldsSignUp> {
  @override
  Widget build(BuildContext context) {
    LogInSignUpProvider logInSignUpProvider =
        context.watch<LogInSignUpProvider>();

    return Column(
      children: [
        TextFieldLogInSignUp(
          title: 'Email',
          hint: 'Email',
          texFieldController: logInSignUpProvider.signUpEmail,
          validator: logInSignUpProvider.validateEmailSignUp,
          prefixIcon: Icons.email,
          suffixIcon: Icons.close,
          deleteOrHide: 'delete',
        ),
        TextFieldLogInSignUp(
          title: 'First Name',
          hint: 'Enter First Name',
          texFieldController: logInSignUpProvider.signUpFirstName,
          validator: (value) {
            if (logInSignUpProvider.signUpFirstName.text.isEmpty) {
              return 'Please enter your first name';
            }
            return null;
          },
          prefixIcon: Icons.person,
          suffixIcon: Icons.close,
          deleteOrHide: 'delete',
        ),
        TextFieldLogInSignUp(
          title: 'Last Name',
          hint: 'Enter Last Name',
          texFieldController: logInSignUpProvider.signUpLastName,
          validator: (value) {
            if (logInSignUpProvider.signUpLastName.text.isEmpty) {
              return 'Please enter your last name';
            }
            return null;
          },
          prefixIcon: Icons.person,
          suffixIcon: Icons.close,
          deleteOrHide: 'delete',
        ),
        TextFieldLogInSignUp(
          title: 'Password',
          hint: 'Password',
          texFieldController: logInSignUpProvider.signUpPassword,
          validator: logInSignUpProvider.validatePasswordSignUp,
          prefixIcon: Icons.lock,
          suffixIcon: Icons.close,
          deleteOrHide: 'hide',
        ),
        TextFieldLogInSignUp(
          title: 'Confirm Password',
          hint: 'Confirm Password',
          texFieldController: logInSignUpProvider.signUpConfirmPassword,
          validator: logInSignUpProvider.validateConfirmPassword,
          prefixIcon: Icons.lock_reset,
          suffixIcon: Icons.close,
          deleteOrHide: 'hide',
        ),
      ],
    );
  }
}
