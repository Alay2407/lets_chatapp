import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lets_chatapp/constants/AppRoutes.dart';

import '../../core/colors/colors.dart';
import '../../constants/strings.dart';
import '../../core/shared_preferences/SharedPreferenceHelper.dart';
import '../../getit_injector.dart';
import '../widgets/homescreen_header.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _prefs = locator.get<SharedPreferenceHelper>();
  final List<String> names = [
    'John',
    'Jane',
    'Michael',
    'Emily',
    'Chris',
  ];

  final List<String> images = [
    'assets/images/img1.png',
    'assets/images/img2.png',
    'assets/images/img3.png',
    'assets/images/img4.png',
    'assets/images/img5.png',
  ];

  final List<String> svgImg = [
    'assets/images/Keys.svg',
    'assets/images/Message.svg',
    'assets/images/notification.svg',
    'assets/images/Help.svg',
    'assets/images/Users.svg',
  ];

  // final String subTitle = "How are you today?";

  final String time = "Today, 09:30 AM";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(color: ColorManager.dark),
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/ellipse.png"),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 61, left: 24, right: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SvgPicture.asset(
                      SvgString.Back,
                      height: 33,
                      // color: ColorManager.cardPin,
                    ),
                    const Text(
                      AppStrings.settings,
                      style: TextStyle(
                        color: ColorManager.white,
                        fontSize: 20,
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          _prefs.deleteValues(key: "token");
                          // Navigator.pushNamedAndRemoveUntil(
                          //   context,
                          //   AppRoutes.onBoarding,
                          //   (route) => route.settings.name ==   AppRoutes.setting,
                          // );
                          Navigator.of(context,rootNavigator: true)
                              .pushNamedAndRemoveUntil(AppRoutes.login, (Route<dynamic> route) => false);
                        },
                        icon: const Icon(
                          Icons.logout,
                          color: ColorManager.white,
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: Card(
                  margin: EdgeInsets.zero,
                  borderOnForeground: true,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  )),
                  color: ColorManager.white,
                  shadowColor: Colors.transparent,
                  elevation: 0,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const SizedBox(
                        height: 14,
                      ),
                      SvgPicture.asset(
                        SvgString.ractLine,
                        color: ColorManager.cardPin,
                        height: 3,
                        width: 30,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          radius: 25,
                        ),
                        title: Text(
                          names[0],
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(names[0]),
                      ),
                      // SizedBox(
                      //   height: 14,
                      // ),
                      Divider(),
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.all(0),
                          // physics: NeverScrollableScrollPhysics(),
                          itemCount: images.length,
                          itemBuilder: (BuildContext context, int index) {
                            final item = names[index];
                            return Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 15),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      child: SvgPicture.asset(svgImg[index]),
                                      radius: 24,
                                      backgroundColor: ColorManager.circularBack,
                                    ),
                                    title: Text(
                                      names[index],
                                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                      names[index],
                                      style: TextStyle(color: ColorManager.subTitle.withOpacity(0.39)),
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
