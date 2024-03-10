import 'package:flutter/material.dart';

import '../design_system/colors.dart';
import '../design_system/ds_text.dart';

class TextFieldLogInSignUp extends StatefulWidget {
  final String title;
  final String? Function(String?)? validator;
  final TextEditingController texFieldController;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final String hint;
  final String deleteOrHide;
  final Color? enabledBorderColor;
  final void Function()? onTapSuffixIcon;

  const TextFieldLogInSignUp({
    Key? key,
    required this.texFieldController,
    required this.hint,
    required this.validator,
    this.prefixIcon,
    this.suffixIcon,
    required this.deleteOrHide,
    required this.title,
    this.onTapSuffixIcon,
    this.enabledBorderColor,
  }) : super(key: key);

  @override
  State<TextFieldLogInSignUp> createState() => _TextFieldLogInSignUpState();
}

class _TextFieldLogInSignUpState extends State<TextFieldLogInSignUp> {
  bool passwordIsHidden = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DS12DarkPurpleText(text: widget.title),
        const SizedBox(
          height: 6,
        ),
        TextFormField(
          textAlignVertical: TextAlignVertical.bottom,
          validator: widget.validator,
          style: const TextStyle(
            fontSize: 16,
            color: DSColors.primaryTextBlack,
          ),
          obscureText: widget.deleteOrHide == 'hide' ? passwordIsHidden : false,
          controller: widget.texFieldController,
          cursorColor: DSColors.primaryActionState1,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(
                left: widget.prefixIcon == null ? 16 : 0, top: 12, bottom: 12),
            filled: true,
            fillColor: Colors.transparent,
            hintText: widget.hint,
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              borderSide: BorderSide(
                color:
                    widget.enabledBorderColor ?? DSColors.greyScaleMediumGrey,
                width: widget.enabledBorderColor == null ? 1.5 : 1,
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              borderSide: BorderSide(
                color: DSColors.primaryActionState1,
                width: 1.5,
              ),
            ),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              borderSide: BorderSide(
                color: DSColors.primaryActionState1,
                width: 1.5,
              ),
            ),
            hintStyle: const TextStyle(
              fontSize: 16,
              color: DSColors.greyScaleDarkGrey,
              fontWeight: FontWeight.w400,
            ),
            prefixIcon: widget.prefixIcon != null
                ? Icon(
                    widget.prefixIcon,
                    color: DSColors.greyScaleDarkGrey,
                  )
                : null,
            suffixIcon: widget.deleteOrHide == "hide"
                ? InkWell(
                    onTap: () {
                      setState(() {
                        passwordIsHidden = !passwordIsHidden;
                      });
                    },
                    child: Icon(
                      passwordIsHidden
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: DSColors.greyScaleDarkGrey,
                    ),
                  )
                : widget.suffixIcon != null
                    ? IconButton(
                        icon: Icon(
                          widget.suffixIcon,
                          color: DSColors.greyScaleDarkGrey,
                        ),
                        onPressed: () {
                          widget.onTapSuffixIcon;
                        },
                      )
                    : null,
          ),
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(
          height: 12,
        ),
      ],
    );
  }
}
