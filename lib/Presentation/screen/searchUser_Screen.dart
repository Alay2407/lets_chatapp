import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lets_chatapp/core/colors/colors.dart';

import '../../constants/AppRoutes.dart';
import '../../constants/strings.dart';
import '../../domain/bloc/searchUser/new/search_user_bloc.dart';
import '../../getit_injector.dart';
import '../widgets/snackbar.dart';

class SearchUserScreen extends StatefulWidget {
  SearchUserScreen({super.key});

  @override
  State<SearchUserScreen> createState() => _SearchUserScreenState();
}

class _SearchUserScreenState extends State<SearchUserScreen> {
  Timer? _debounce;
  final List<String> images = [
    'assets/images/img1.png',
    'assets/images/img2.png',
    'assets/images/img3.png',
    'assets/images/img4.png',
    'assets/images/img5.png',
    'assets/images/img1.png',
    'assets/images/img2.png',
    'assets/images/img3.png',
    'assets/images/img4.png',
    'assets/images/img5.png',
    'assets/images/img1.png',
    'assets/images/img2.png',
    'assets/images/img3.png',
    'assets/images/img4.png',
    'assets/images/img5.png',
    'assets/images/img1.png',
    'assets/images/img2.png',
    'assets/images/img3.png',
    'assets/images/img4.png',
    'assets/images/img5.png',
  ];

  final String subTitle = "How are you today?";

  SearchUserBloc searchUserBloc = locator<SearchUserBloc>();
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    searchUserBloc.searchResults.clear();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemStatusBarContrastEnforced: false,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
    );
    return BlocListener(
      bloc: searchUserBloc,
      listener: (context, state) {
        if (state is SearchUserLoadingState) {
          const CircularProgressIndicator();
        } else if (state is SearchUserFinishedState) {
          showSnackbar(color: ColorManager.darkGrey, context: context, message: "Received");
        } else if (state is SearchUserStateErrorState) {
          showSnackbar(color: ColorManager.darkGrey, context: context, message: state.message.toString());
        }
      },
      child: Scaffold(
        backgroundColor: ColorManager.white,
        appBar: AppBar(
          leading: GestureDetector(
            child: const Icon(Icons.keyboard_backspace),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: ColorManager.white,
          automaticallyImplyLeading: false,
          title: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              color: ColorManager.lightGray,
              borderRadius: BorderRadius.circular(10.0),
              // border: Border.all(color: ColorManager.dark)
            ),
            child: TextField(
              controller: _controller,
              onChanged: (value) {
                _debounce?.cancel();
                _debounce = Timer(Duration(milliseconds: 300), () {
                  if (value.isEmpty) {
                    // setState(() {
                    //   searchUserBloc.searchResults.clear();
                    // });
                    searchUserBloc.add(ClearUserFromSearchtxt());
                  } else {
                    searchUserBloc.add(FetchUsers(value));
                  }
                });
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search...',
                // Add a clear button to the search bar
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    _controller.clear();
                    searchUserBloc.add(
                      ClearUserFromSearchtxt(),
                    );
                  },
                ),
                // Add a search icon or button to the search bar
                prefixIcon: IconButton(
                  icon: SvgPicture.asset(
                    SvgString.searchIcon,
                    color: ColorManager.dark,
                  ),
                  onPressed: () => () {},
                ),
              ),
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            BlocBuilder(
              bloc: searchUserBloc,
              builder: (context, state) {
                if (state is SearchUserLoadingState) {
                  return const Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: CircularProgressIndicator(),
                        ),
                      ],
                    ),
                  );
                } else if (state is SearchUserFinishedState) {
                  return Expanded(
                    child: Column(
                      children: [
                        searchUserBloc.searchResults.isEmpty
                            ? Container()
                            : const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 23, vertical: 15),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'People',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: state.searchUserList.length,
                            itemBuilder: (context, index) {
                              final user = state.searchUserList;
                              final specificUser = state.searchUserList[index];
                              return GestureDetector(
                                onTap: () {
                                  print("User id is ==>  ${user[index].id}");
                                  print("User name is ==>  ${user[index].name}");
                                  print("User email is ==>  ${user[index].email}");

                                  Navigator.of(context, rootNavigator: true).pushNamed(
                                    AppRoutes.chatScreen,
                                    arguments: specificUser,
                                  );
                                },
                                child: ListTile(
                                  leading: CircleAvatar(
                                    radius: 29,
                                    child: Image.asset(images[index]),
                                  ),
                                  title: Text(
                                    user[index].name.toString(),
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
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (state is SearchUserStateErrorState) {
                  return const Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text('Data not found'),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text('Search User for chat'),
                        ),
                      ],
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
