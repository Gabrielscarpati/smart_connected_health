import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:smart_connected_health/log_in/views/text_fields_log_in.dart';

import '../../provider/user_provider.dart';
import '../../widgets/login_singup_body.dart';
import 'footer_log_in.dart';

class LogInBody extends StatelessWidget {
  const LogInBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LogInSignUpProvider logInSignUpProvider =
        context.watch<LogInSignUpProvider>();

    return SingleChildScrollView(
      child: Form(
        key: logInSignUpProvider.formKeyAuthenticationLogIn,
        child: const LoginSignupBody(
          title: 'Log In',
          child: Column(
            children: [
              TextFieldsLogIn(),
              FooterLogIn(),
            ],
          ),
        ),
      ),
    );
  }
}
