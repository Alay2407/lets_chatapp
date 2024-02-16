import 'package:flutter/material.dart';
import 'package:lets_chatapp/Presentation/widgets/gradientBtn.dart';
import 'package:lets_chatapp/Presentation/widgets/header.dart';
import 'package:lets_chatapp/Presentation/widgets/txtButton.dart';
import 'package:lets_chatapp/core/colors/colors.dart';
import 'package:lets_chatapp/core/utilities/strings.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Header(),
              ],
            ),
            Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 60),
                  child: Text(
                    AppStrings.loginToChatBox,
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
                  padding: EdgeInsets.only(top: 38),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image(
                        image: AssetImage(
                          "assets/images/fb2.png",
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Image(
                          image: AssetImage(
                            "assets/images/google2.png",
                          ),
                        ),
                      ),
                      Image(
                        image: AssetImage(
                          "assets/images/apple2.png",
                        ),
                      ),
                    ],
                  ),
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
                        height: 157,
                      ),
                    ],
                  ),
                ),
              GradientBtn(text: AppStrings.login, onpress: () {

              },),
                const Center(
                  child: Text(
                    AppStrings.forgetPass,
                    style: TextStyle(color: ColorManager.txtColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
