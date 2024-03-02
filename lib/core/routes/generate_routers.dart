import 'package:flutter/material.dart';
import 'package:lets_chatapp/Presentation/authentication/loginPage.dart';
import 'package:lets_chatapp/Presentation/authentication/signupPage.dart';
import 'package:lets_chatapp/Presentation/authentication/welcomePage.dart';
import 'package:lets_chatapp/Presentation/screen/chat_screen.dart';
import 'package:lets_chatapp/Presentation/screen/home_Screen.dart';
import 'package:lets_chatapp/Presentation/screen/message_screen.dart';
import 'package:lets_chatapp/Presentation/screen/searchUser_Screen.dart';
import 'package:lets_chatapp/Presentation/screen/settings_screen.dart';

import '../../Presentation/authentication/changePassPage.dart';
import '../../constants/AppRoutes.dart';

Route<dynamic> onGenerate(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.onBoarding:
      return MaterialPageRoute(builder: (context) => FirstPage());
    case AppRoutes.setting:
      return MaterialPageRoute(builder: (context) => SettingsScreen());
    case AppRoutes.login:
      return MaterialPageRoute(builder: (context) => LoginPage());
    case AppRoutes.register:
      return MaterialPageRoute(builder: (context) => SignupPage());
    case AppRoutes.homeScreen:
      return MaterialPageRoute(builder: (context) => HomeScreen());
    case AppRoutes.chatScreen:
      return MaterialPageRoute(builder: (context) => ChatScreen());
    case AppRoutes.searchScreen:
      return MaterialPageRoute(builder: (context) => SearchUserScreen());
    case AppRoutes.changePassScreen:
      return MaterialPageRoute(builder: (context) => ChangePassPage());
    default:
      return MaterialPageRoute(builder: (context) => LoginPage());
  }
}
