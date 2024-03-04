import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lets_chatapp/core/colors/colors.dart';

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
          showSnackbar(color: ColorManager.darkGrey, context: context, message: 'User Received');
        } else if (state is SearchUserStateErrorState) {
          showSnackbar(color: ColorManager.darkGrey, context: context, message: state.message.toString());
        }
      },
      child: Scaffold(
        backgroundColor: ColorManager.white,
        appBar: AppBar(
          backgroundColor: ColorManager.white,
          automaticallyImplyLeading: false,
          title: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                color: ColorManager.lightGray,
                borderRadius: BorderRadius.circular(10.0),
                // border: Border.all(color: ColorManager.dark)
              ),
              child: TextField(
                controller: _controller,
                onChanged: (value) {
                  // setState(() {
                  //   _searchQuery = value;
                  //   _search();
                  // });

                  searchUserBloc.add(FetchUsers(value));
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search...',
                  // Add a clear button to the search bar
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        _controller.clear();
                        searchUserBloc.searchResults.clear();
                      });
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
              )),
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 25),
          //   child: Visibility(
          //     visible: searchUserBloc.searchResults.isEmpty ? false : true,
          //     child: const Text(
          //       'People',
          //       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          //     ),
          //   ),
          // ),
          BlocBuilder(
            bloc: searchUserBloc,
            builder: (context, state) {
              if (state is SearchUserInitial) {
                const Center(child: Text('Data not found'));
              } else if (state is SearchUserLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is SearchUserFinishedState) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: state.searchUserList.length,
                    itemBuilder: (context, index) {
                      final user = state.searchUserList;
                      return ListTile(
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
                      );
                    },
                  ),
                );
              } else if (state is SearchUserStateErrorState) {
                const Center(child: Text('Data not found'));
              }
              return Container();
            },
          )
        ]),
      ),
    );
  }
}
