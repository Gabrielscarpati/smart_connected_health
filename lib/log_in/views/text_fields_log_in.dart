import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_connected_health/provider/user_provider.dart';

import '../../widgets/widgets.dart';

class TextFieldsLogIn extends StatefulWidget {
  const TextFieldsLogIn({Key? key}) : super(key: key);

  @override
  State<TextFieldsLogIn> createState() => _TextFieldsLogInState();
}

class _TextFieldsLogInState extends State<TextFieldsLogIn> {
  @override
  Widget build(BuildContext context) {
    LogInSignUpProvider logInSignUpProvider =
        context.read<LogInSignUpProvider>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextFieldLogInSignUp(
          title: 'Email',
          hint: 'Email',
          texFieldController: logInSignUpProvider.logInEmail,
          validator: logInSignUpProvider.validateEmailLogIn,
          prefixIcon: Icons.email_outlined,
          suffixIcon: Icons.close,
          deleteOrHide: 'delete',
        ),
        TextFieldLogInSignUp(
          title: 'Password',
          hint: 'Enter Password',
          texFieldController: logInSignUpProvider.logInPassword,
          validator: logInSignUpProvider.validatePasswordLogIn,
          prefixIcon: Icons.lock_outline,
          suffixIcon: Icons.close,
          deleteOrHide: 'hide',
        ),
      ],
    );
  }
}
