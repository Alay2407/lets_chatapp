import 'package:flutter/material.dart';
import 'package:lets_chatapp/constants/AppRoutes.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 61, left: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(context, AppRoutes.onBoarding, (Route<dynamic> route) => false);
            },
            child: const Icon(
              Icons.keyboard_backspace_outlined,
            ),
          ),
        ],
      ),
    );
  }
}
