import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lets_chatapp/constants/strings.dart';

import '../../core/colors/colors.dart';
import '../widgets/homescreen_header.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({super.key});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
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
               HomeScreenHeader(
                headerName: AppStrings.calls,
                svgIconsleft: "assets/images/searchIcon.svg",
                svgIconsright: "assets/images/callAdd.svg",
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
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Row(children: [
                          Text(

                            AppStrings.recent,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ]),
                      ),

                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.all(0),
                          itemCount: images.length,
                          itemBuilder: (BuildContext context, int index) {
                            final item = names[index];
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      radius: 25,
                                      child: Image.asset('assets/images/img3.png'),
                                    ),
                                    title: Text(
                                      names[index],
                                      style: const TextStyle(
                                        color: ColorManager.chatName,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Row(
                                      children: [
                                        SvgPicture.asset(SvgString.incoming),
                                        SizedBox(width: 6,),
                                        Text(
                                          time,
                                          style: TextStyle(
                                            color: ColorManager.subTitle.withOpacity(0.50),
                                            // fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 16),
                                          child: SvgPicture.asset(SvgString.Call),
                                        ),
                                        SvgPicture.asset(SvgString.Video),
                                      ],
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
