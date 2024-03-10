import 'package:flutter/cupertino.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../charts/chat_screen.dart';
import '../../design_system/colors.dart';
import '../../design_system/ds_text.dart';
import '../../log_in/log_in_screen.dart';
import '../../ultils/app_routes.dart';
import '../../widgets/loading_buttom.dart';

class FooterSignUp extends StatefulWidget {
  const FooterSignUp({Key? key}) : super(key: key);

  @override
  State<FooterSignUp> createState() => _FooterSignUpState();
}

class _FooterSignUpState extends State<FooterSignUp> {
  RoundedLoadingButtonController controller = RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const DSStandardText(
          textAlign: TextAlign.start,
          text:
              'Password must be 8 or more characters and contain at least one number and one special character.',
          fontSize: 11,
          fontWeight: FontWeight.w400,
          color: DSColors.greyScaleDarkGrey,
        ),
        const SizedBox(
          height: 12,
        ),
        LoadingButton(
          isButtonEnabled: true,
          buttonText: 'SIGN UP',
          onPressed: () async {
            AppRoutes.push(context, const ChartScreen());

            controller.start();
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
                color: DSColors.greyScaleMediumGrey,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 32,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: DSColors.greyScaleMediumGrey,
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: DSStandardText(
                    text: 'OR',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: DSColors.greyScaleMediumGrey,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 1,
                color: DSColors.greyScaleMediumGrey,
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
                text: "Already have an account?  ",
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: DSColors.greyScaleDarkGrey,
              ),
              DSStandardText(
                text: "LOG IN",
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: DSColors.primaryActionState1,
              ),
            ],
          ),
          onTap: () {
            AppRoutes.replace(context, const LogInScreen());
          },
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
