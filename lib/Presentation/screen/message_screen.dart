import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lets_chatapp/Presentation/widgets/homescreen_header.dart';
import 'package:lets_chatapp/constants/strings.dart';
import '../../constants/AppRoutes.dart';
import '../../core/colors/colors.dart';
import 'package:flutter_slidable/src/slidable.dart';

class MessageScreen extends StatefulWidget {
  MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
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

  final String subTitle = "How are you today?";

  final String time = "2 min ago";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: ColorManager.dark,
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
                headerName: AppStrings.home,
                svgIconsleft: SvgString.searchIcon,
                svgIconsright: "",
                searchOnpress: () {
                  Navigator.of(context, rootNavigator: true).pushNamed(
                    AppRoutes.searchScreen,
                  );
                },
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 42),
                  child: SizedBox(
                    height: 100,
                    child: ListView.builder(
                      padding: EdgeInsets.only(left: 24.0),
                      scrollDirection: Axis.horizontal,
                      itemCount: images.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(12.0),
                              child: CircleAvatar(
                                radius: 29,
                                child: SvgPicture.asset(
                                  SvgString.img6,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                names[index],
                                style: const TextStyle(color: ColorManager.white),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
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
                    // mainAxisSize: MainAxisSize.max,
                    // mainAxisAlignment: MainAxisAlignment.start,
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
                        height: 14,
                      ),
                      Expanded(
                        child: ListView.builder(
                          // scrollDirection: Axis.horizonvtal,
                          padding: EdgeInsets.all(0),
                          itemCount: images.length,
                          itemBuilder: (BuildContext context, int index) {
                            final item = names[index];
                            return Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 16),
                                  child: Slidable(
                                    // key: const ValueKey(0),
                                    endActionPane: ActionPane(
                                      extentRatio: 0.3,
                                      motion: ScrollMotion(),
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 16),
                                          child: CircleAvatar(
                                            backgroundColor: ColorManager.notificaback,
                                            radius: 18,
                                            child: SvgPicture.asset(SvgString.notification),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              images.removeAt(index);
                                            });
                                          },
                                          child: CircleAvatar(
                                            backgroundColor: ColorManager.red,
                                            radius: 18,
                                            child: SvgPicture.asset(SvgString.trash),
                                          ),
                                        ),
                                      ],
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.of(context, rootNavigator: true).pushNamed(
                                          AppRoutes.chatScreen,
                                        );
                                      },
                                      child: ListTile(
                                          leading: CircleAvatar(
                                            radius: 29,
                                            child: Image.asset(SvgString.img3),
                                          ),
                                          title: Text(
                                            names[index],
                                            style: const TextStyle(
                                              color: ColorManager.chatName,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          subtitle: Text(
                                            subTitle,
                                            style: TextStyle(
                                              color: ColorManager.subTitle.withOpacity(0.50),
                                              // fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          trailing: Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                time,
                                                style: TextStyle(
                                                  color: ColorManager.subTitle.withOpacity(0.50),
                                                  // fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(height: 7),
                                              const CircleAvatar(
                                                backgroundColor: ColorManager.red,
                                                radius: 10,
                                                child: Center(
                                                    child: Text(
                                                  '3',
                                                  style: TextStyle(fontSize: 12, color: ColorManager.white, fontWeight: FontWeight.w900),
                                                )),
                                              ),
                                            ],
                                          )),
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
