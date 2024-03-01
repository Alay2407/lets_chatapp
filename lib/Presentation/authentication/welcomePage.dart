import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lets_chatapp/Presentation/widgets/txtButton.dart';
import 'package:lets_chatapp/constants/strings.dart';

import '../../constants/AppRoutes.dart';
import '../../core/colors/colors.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent, systemStatusBarContrastEnforced: false, statusBarIconBrightness: Brightness.light, statusBarBrightness: Brightness.light));
    return Scaffold(
      backgroundColor: ColorManager.dark,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/ellipse.png"),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 35, left: 26),
                        child: Text(
                          'Connect\nfriends\neasily &\nquickly',
                          style: TextStyle(
                            fontSize: 68,
                            color: ColorManager.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 39, left: 26, right: 11),
                        child: Text(
                          AppStrings.welcomTxt,
                          style: TextStyle(
                            fontSize: 16,
                            color: ColorManager.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  TxtButton(
                    text: AppStrings.signUp,
                    onpress: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.register,
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.login,
                        );
                      },
                      child: RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: AppStrings.existingAccount,
                              style: TextStyle(color: Colors.white, fontSize: 14),
                            ),
                            TextSpan(
                              text: " ",
                              style: TextStyle(color: Colors.white, fontSize: 14),
                            ),
                            TextSpan(
                              text: AppStrings.login,
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ],
                        ),
                      ),
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
                              color: ColorManager.white,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 38,bottom: 20),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(radius: 22,child: SvgPicture.asset(SvgString.facebook), backgroundColor: ColorManager.white),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: CircleAvatar(radius: 22,child: SvgPicture.asset(SvgString.google), backgroundColor: ColorManager.white),
                        ),
                        CircleAvatar(radius: 22,
                            backgroundColor: ColorManager.white,
                            child: SvgPicture.asset(
                              SvgString.apple,
                              color: ColorManager.dark,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
