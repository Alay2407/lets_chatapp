import 'package:flutter/material.dart';
import 'package:lets_chatapp/Presentation/authentication/loginPage.dart';
import 'package:lets_chatapp/Presentation/authentication/signupPage.dart';
import 'package:lets_chatapp/Presentation/widgets/txtButton.dart';
import 'package:lets_chatapp/core/utilities/strings.dart';

import '../../core/colors/colors.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
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
                        padding: EdgeInsets.only(top: 85, left: 26),
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
                  const Padding(
                    padding: EdgeInsets.only(top: 38),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image(
                          image: AssetImage(
                            "assets/images/fb.png",
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Image(
                            image: AssetImage(
                              "assets/images/google.png",
                            ),
                          ),
                        ),
                        Image(
                          image: AssetImage(
                            "assets/images/apple.png",
                          ),
                        )
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
                  TxtButton(
                    text: AppStrings.signUp,
                    onpress: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ));
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 56),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignupPage(),
                            ));
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
