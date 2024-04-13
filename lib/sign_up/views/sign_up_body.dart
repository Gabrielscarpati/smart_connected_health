import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_connected_health/sign_up/views/text_fields_sign_up.dart';

import '../../provider/user_provider.dart';
import '../../widgets/login_singup_body.dart';
import 'footer_sign_up.dart';

class SignUpBody extends StatelessWidget {
  const SignUpBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LogInSignUpProvider logInSignUpProvider =
        context.watch<LogInSignUpProvider>();

    return SingleChildScrollView(
      child: Form(
        key: logInSignUpProvider.formKeyAuthenticationSignUp,
        child: const LoginSignupBody(
          title: 'Sign Up',
          child: Column(
            children: [TextFieldsSignUp(), FooterSignUp()],
          ),
        ),
      ),
    );
  }
}
