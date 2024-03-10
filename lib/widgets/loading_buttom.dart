import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../design_system/colors.dart';
import '../design_system/ds_text.dart';

class LoadingButton extends StatelessWidget {
  final String buttonText;
  bool? isButtonEnabled;
  final RoundedLoadingButtonController controller;
  final void Function() onPressed;
  LoadingButton({
    Key? key,
    required this.buttonText,
    required this.onPressed,
    required this.controller,
    this.isButtonEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RoundedLoadingButton(
        height: 40,
        width: 250,
        color: const Color(0xFF265F56),
        borderRadius: 30,
        controller: controller,
        onPressed: isButtonEnabled == null
            ? null
            : isButtonEnabled!
                ? onPressed
                : null,
        elevation: 0,
        child: Container(
          decoration: isButtonEnabled == null
              ? DSColors.buttonBoxDecoration
              : isButtonEnabled == true
                  ? DSColors.buttonBoxDecoration
                  : DSColors.buttonDeactivatedBoxDecoration,
          child: Center(
            child: DSStandardText(
              text: buttonText,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isButtonEnabled == null
                  ? DSColors.greyScaleWhite
                  : isButtonEnabled == true
                      ? DSColors.greyScaleWhite
                      : const Color(0xFF385E36).withOpacity(0.4),
            ),
          ),
        ),
      ),
    );
  }
}
