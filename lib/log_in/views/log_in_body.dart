import 'package:flutter/cupertino.dart';
import 'package:smart_connected_health/log_in/views/text_fields_log_in.dart';

import '../../widgets/login_singup_body.dart';
import 'footer_log_in.dart';

class LogInBody extends StatelessWidget {
  const LogInBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKeyAuthenticationLogIn = GlobalKey<FormState>();

    return SingleChildScrollView(
      child: Form(
        key: formKeyAuthenticationLogIn,
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
