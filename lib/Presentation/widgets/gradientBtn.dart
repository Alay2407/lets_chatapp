import 'package:flutter/material.dart';
import 'package:lets_chatapp/core/colors/colors.dart';

class GradientBtn extends StatelessWidget {
  final String text;

  // final double height;
  final VoidCallback onpress;

  const GradientBtn({Key? key, required this.text, required this.onpress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpress,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 26, vertical: 25),
        child: Stack(
          children: [
            Container(
              height: 48,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/gradientImg.png',
                  ),
                ),
              ),
              child:Center(
                  child: Text(
                text.toString(),
                style: const TextStyle(
                  color: ColorManager.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
