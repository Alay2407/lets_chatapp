import 'package:flutter/material.dart';
import 'package:lets_chatapp/Presentation/screen/home_Screen.dart';
import 'package:lets_chatapp/Presentation/widgets/gradientBtn.dart';
import 'package:lets_chatapp/Presentation/widgets/header.dart';
import 'package:lets_chatapp/core/colors/colors.dart';
import 'package:lets_chatapp/core/utilities/strings.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Row(
              children: [
                Header(),
              ],
            ),
            Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 60),
                  child: Text(
                    AppStrings.signUp,
                    style: TextStyle(
                      fontSize: 18,
                      color: ColorManager.txtColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 19, left: 41, right: 41),
                  child: Text(AppStrings.welBackTxt),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 30, left: 28, right: 28),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Divider(),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 7),
                        child: Text(
                          AppStrings.OR,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ColorManager.lightgrey,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.yourName,
                        style: TextStyle(color: ColorManager.txtColor),
                      ),
                      TextField(),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        AppStrings.yourEmail,
                        style: TextStyle(color: ColorManager.txtColor),
                      ),
                      TextField(),
                      SizedBox(
                        height: 30,
                      ),
                      Text(AppStrings.password,
                          style: TextStyle(
                            color: ColorManager.txtColor,
                          )),
                      TextField(),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        AppStrings.conPassword,
                        style: TextStyle(color: ColorManager.txtColor),
                      ),
                      TextField(),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 70,
                ),
                GradientBtn(
                  text: AppStrings.createAcc,
                  onpress: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                    print('clicked');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
