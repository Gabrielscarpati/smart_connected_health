import 'package:flutter/cupertino.dart';

class LoginSignupBody extends StatelessWidget {
  final String title;
  final Column child;
  const LoginSignupBody({Key? key, required this.child, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 48.0,
            left: 24.0,
            right: 24.0,
          ),
          child: Container(
            height: 180,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      'https://upload.wikimedia.org/wikipedia/commons/1/13/Official_USF_Bulls_Athletic_Logo.png'),
                  fit: BoxFit.contain),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 76.0,
            left: 24.0,
            right: 24.0,
          ),
          child: Column(
            children: [
              Container(
                height: 153,
              ),
              const SizedBox(
                height: 30,
              ),
              child
            ],
          ),
        ),
      ],
    );
  }
}
