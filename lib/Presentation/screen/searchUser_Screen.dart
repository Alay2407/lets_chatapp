import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lets_chatapp/core/colors/colors.dart';

import '../../constants/strings.dart';

class SearchUserScreen extends StatefulWidget {
  SearchUserScreen({super.key});

  @override
  State<SearchUserScreen> createState() => _SearchUserScreenState();
}

class _SearchUserScreenState extends State<SearchUserScreen> {
  ///Initially search query is empty
  String _searchQuery = '';
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

  ///Intially this is a empty List if math than Add inside list here and show on Ui
  List<String> _searchResults = [];

  ///this function call update data
  void _search() {
    _searchResults.clear();
    if (_searchQuery.isNotEmpty) {
      ///show if and only first latter match from the list
      names.forEach((item) {
        if (item.toLowerCase().startsWith(_searchQuery.toLowerCase())) {
          _searchResults.add(item);
        }
      });

      ///show if any later inside match from the list
      // names.forEach((item) {
      //   if (item.toLowerCase().contains(_searchQuery.toLowerCase())) {
      //     _searchResults.add(item);
      //   }
      // });
    }
  }

  var _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemStatusBarContrastEnforced: false,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
    );
    return Scaffold(
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
                setState(() {
                  _searchQuery = value;
                  _search();
                });
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search...',
                // Add a clear button to the search bar
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    // _controller.clear();
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
      body: _searchResults.length == 0
          ? Center(
              child: Container(
              child: const Text('Data not found'),
            ))
          : Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 25),
                child: Visibility(
                  visible: _searchResults == 0 ? false : true,
                  child: const Text(
                    'People',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _searchResults.length,
                  itemBuilder: (context, index) {
                    // return ListTile(
                    //   title: Text(_searchResults[index]),
                    // );
                    return ListTile(
                      leading: CircleAvatar(
                        radius: 29,
                        child: Image.asset(images[index]),
                      ),
                      title: Text(
                        _searchResults[index],
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
              )
            ]),
    );
  }
}
