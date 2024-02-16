import 'package:flutter/material.dart';

import '../../core/colors/colors.dart';

class TxtButton extends StatelessWidget {
  final String text;

  // final double height;
  final VoidCallback onpress;

  const TxtButton({Key? key, required this.text, required this.onpress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 30),
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              backgroundColor: ColorManager.white.withOpacity(0.37,)),
          onPressed: onpress,
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
