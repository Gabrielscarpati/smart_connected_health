import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:smart_connected_health/charts/chat_screen.dart';

import '../../design_system/colors.dart';
import '../../design_system/ds_text.dart';
import '../../provider/user_provider.dart';
import '../../sign_up/sign_up_screen.dart';
import '../../ultils/app_routes.dart';
import '../../widgets/loading_buttom.dart';

class FooterLogIn extends StatefulWidget {
  const FooterLogIn({Key? key}) : super(key: key);

  @override
  State<FooterLogIn> createState() => _FooterLogInState();
}

class _FooterLogInState extends State<FooterLogIn> {
  RoundedLoadingButtonController controller = RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    LogInSignUpProvider logInSignUpProvider =
        context.watch<LogInSignUpProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(
          height: 12,
        ),
        LoadingButton(
          buttonText: 'LOG IN',
          onPressed: () async {
            await logInSignUpProvider.checkConditionsLogInUser(context);

            AppRoutes.push(context, const ChartScreen());
            controller.reset();
          },
          controller: controller,
        ),
        const SizedBox(
          height: 24,
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 1,
                color: const Color(0xFFC2C1C2),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 32,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color(0xFFC2C1C2),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: DSStandardText(
                    text: 'OR',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFC2C1C2),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 1,
                color: const Color(0xFFC2C1C2),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        GestureDetector(
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DSStandardText(
                text: "New here?  ",
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: DSColors.greyScaleDarkGrey,
              ),
              DSStandardText(
                text: "SIGN UP",
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: DSColors.primaryActionState1,
              ),
            ],
          ),
          onTap: () {
            AppRoutes.replace(context, const SignUpScreen());
          },
        ),
        const SizedBox(
          height: 24,
        ),
      ],
    );
  }
}
