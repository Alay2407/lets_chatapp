import 'dart:core';
import 'package:lets_chatapp/Presentation/screen/chat_screen.dart';
import 'package:lets_chatapp/data/Model/user/searchUser/searchUserDataModel.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:lets_chatapp/Presentation/widgets/homescreen_header.dart';
import 'package:lets_chatapp/Presentation/widgets/snackbar.dart';
import 'package:lets_chatapp/constants/strings.dart';
import 'package:lets_chatapp/data/repository_impl/getAllChatRepositoryImpl.dart';
import 'package:lets_chatapp/domain/bloc/chat/getAllChat/get_all_chat_cubit.dart';
import 'package:lets_chatapp/getit_injector.dart';
import '../../constants/AppRoutes.dart';
import '../../core/colors/colors.dart';
import 'package:flutter_slidable/src/slidable.dart';

class MessageScreen extends StatefulWidget {
  MessageScreen({super.key});

  final GetAllChatRepositoryImpl getAllChatRepositoryImpl = GetAllChatRepositoryImpl();

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  GetAllChatCubit getAllChatCubit = locator<GetAllChatCubit>();

  @override
  void initState() {
    getAllChatCubit.getChat();
    super.initState();
  }

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
    return BlocListener(
      bloc: getAllChatCubit,
      listener: (context, state) {
        if (state is GetAllChatLoadingState) {
          const CircularProgressIndicator();
        } else if (state is GetAllChatFinishedState) {
          showSnackbar(color: ColorManager.darkGrey, context: context, message: 'All Chat Received');
        } else if (state is GetAllChatErrorState) {
          showSnackbar(color: ColorManager.darkGrey, context: context, message: state.message.toString());
        }
      },
      child: Scaffold(
        // backgroundColor: ColorManager.dark,
        body: Stack(
          children: [
            Container(color: ColorManager.dark),
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(SvgString.ellipse),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Column(
              children: [
                HomeScreenHeader(
                  headerName: AppStrings.home,
                  svgIconsleft: SvgString.searchIcon,
                  svgIconsright: SvgString.searchIcon,
                  searchOnpress: () {
                    Navigator.of(context, rootNavigator: true).pushNamed(
                      AppRoutes.searchScreen,
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 42),
                  child: SizedBox(
                    height: 100,
                    child: ListView.builder(
                      padding: EdgeInsets.only(left: 24.0),
                      scrollDirection: Axis.horizontal,
                      itemCount: images.length,
                      itemBuilder: (BuildContext context, int index) {
                        return const Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(12.0),
                              child: CircleAvatar(
                                radius: 29,
                                // child: SvgPicture.asset(
                                //   SvgString.img6,
                                // ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "",
                                style: TextStyle(color: ColorManager.white),
                              ),
                            ),
                          ],
                        );
                      },
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
                      // mainAxisAlignment: MainAxisAlignment.center,
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
                        BlocBuilder(
                          bloc: getAllChatCubit,
                          builder: (context, state) {
                            if (state is GetAllChatFinishedState) {
                              var data = state.getAllChat!.data;
                              var chats = data!.chats;

                              return Expanded(
                                child: ListView.builder(
                                  // scrollDirection: Axis.horizonvtal,
                                  padding: const EdgeInsets.all(0),
                                  itemCount: chats!.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    String formattedTime = "";
                                    DateTime utcTime = DateTime.parse(chats[index].time.toString());
                                    DateTime indiaTime = utcTime.add(const Duration(hours: 5, minutes: 30));
                                    return Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 16),
                                          child: Slidable(
                                            // key: const ValueKey(0),
                                            endActionPane: ActionPane(
                                              extentRatio: 0.3,
                                              motion: const ScrollMotion(),
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
                                                // ChatScreen(name: chats[index].name.toString(),);
                                                // Navigator.of(context, rootNavigator: true).push(
                                                //   MaterialPageRoute(
                                                //     builder: (context) => ChatScreen(
                                                //       searchUserData: SearchUserData(
                                                //         email: chats[index].email,
                                                //       ),
                                                //     ),
                                                //   ),
                                                // );
                                                print('Chat id is ====>  ${chats[index].chatID}');
                                                print('Email id is ====>  ${chats[index].email}');

                                                String? chatId = chats[index].chatID;
                                                getAllChatCubit.getSingleChat(chatId!);
                                              },
                                              child: ListTile(
                                                  leading: CircleAvatar(
                                                    radius: 29,
                                                    child: Image.asset(SvgString.img3),
                                                  ),
                                                  title: Text(
                                                    chats[index].name.toString(),
                                                    style: const TextStyle(
                                                      color: ColorManager.chatName,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  subtitle: Text(
                                                    chats[index].last_message.toString(),
                                                    style: TextStyle(
                                                      color: ColorManager.subTitle.withOpacity(0.50),
                                                      // fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  trailing: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        formatMessageTime(indiaTime),
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
                              );
                            }
                            return const Center(child: CircularProgressIndicator());
                          },
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  String formatMessageTime(DateTime messageTime) {
    // Get current date
    DateTime now = DateTime.now();

    // Get yesterday's date
    DateTime yesterday = DateTime(now.year, now.month, now.day - 1);

    // Get the day before yesterday's date
    DateTime dayBeforeYesterday = DateTime(now.year, now.month, now.day - 2);

    // Format for today
    if (messageTime.year == now.year && messageTime.month == now.month && messageTime.day == now.day) {
      return DateFormat.jm().format(messageTime); // Return time only
    }

    // Format for yesterday
    else if (messageTime.year == yesterday.year && messageTime.month == yesterday.month && messageTime.day == yesterday.day) {
      return 'Yesterday';
    }

    // Format for the day before yesterday
    else if (messageTime.year == dayBeforeYesterday.year && messageTime.month == dayBeforeYesterday.month && messageTime.day == dayBeforeYesterday.day) {
      return 'Day before yesterday';
    }

    // Format for other dates
    else {
      return DateFormat('dd/MM/yyyy').format(messageTime); // Return date
    }
  }
}
