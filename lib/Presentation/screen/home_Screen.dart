import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lets_chatapp/Presentation/screen/call_screen.dart';
import 'package:lets_chatapp/Presentation/screen/contact_screen.dart';
import 'package:lets_chatapp/Presentation/screen/message_screen.dart';
import 'package:lets_chatapp/Presentation/screen/settings_screen.dart';
import 'package:lets_chatapp/core/colors/colors.dart';

import '../../constants/strings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  PageController? _pageController = PageController();

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context, int index) {
    return {
      '/': (context) {
        return [
          MessageScreen(),
          const CallScreen(),
          const ContactScreen(),
          const SettingsScreen(),
        ].elementAt(index);
      },
    };
  }

  Widget _buildOffstageNavigator(int index) {
    var routeBuilders = _routeBuilders(context, index);

    return Offstage(
      offstage: selectedIndex != index,
      child: Navigator(
        key: _navigatorKeys[index],
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
            builder: (context) => routeBuilders[routeSettings.name]!(context),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent, systemStatusBarContrastEnforced: false, statusBarIconBrightness: Brightness.light, statusBarBrightness: Brightness.light));
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab = !await _navigatorKeys[selectedIndex].currentState!.maybePop();

        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        backgroundColor: ColorManager.dark,
        body: PageView(
          onPageChanged: (index) {
            setState(() => selectedIndex = index);
          },
          controller: _pageController,
          children: [
            Stack(
              children: [
                _buildOffstageNavigator(0),
                _buildOffstageNavigator(1),
                _buildOffstageNavigator(2),
                _buildOffstageNavigator(3),
              ],
            )
          ],
        ),
        bottomNavigationBar: Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: SizedBox(
            height: 100,
            child: BottomNavigationBar(
              backgroundColor: ColorManager.white,
              // selectedItemColor: ColorManager.darkNavy,
              selectedLabelStyle: const TextStyle(color: ColorManager.naviBlue),
              type: BottomNavigationBarType.fixed,
              // fixedColor: Colors.grey,
              currentIndex: selectedIndex,
              // unselectedLabelStyle: TextStyle(color: ColorManager.naviBlue),
              // showUnselectedLabels: true,
              unselectedItemColor: ColorManager.grey,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  label: "Message",
                  icon: Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: SvgPicture.asset(
                      SvgString.Message,
                      height: 26,
                    ),
                  ),
                  activeIcon: Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: SvgPicture.asset(
                      SvgString.active_Message,
                      height: 26,
                    ),
                  ),
                ),
                BottomNavigationBarItem(
                  label: "Calls",
                  icon: Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: SvgPicture.asset(
                      SvgString.Call,
                      height: 26,
                    ),
                  ),
                  activeIcon: Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: SvgPicture.asset(
                      SvgString.active_Call,
                      height: 26,
                    ),
                  ),
                ),
                BottomNavigationBarItem(
                  label: "Contacts",
                  icon: Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: SvgPicture.asset(
                      SvgString.user,
                      height: 26,
                    ),
                  ),
                  activeIcon: Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: SvgPicture.asset(
                      SvgString.active_user,
                      height: 26,
                    ),
                  ),
                ),
                BottomNavigationBarItem(
                  label: "Settings",
                  icon: Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: SvgPicture.asset(
                      SvgString.settings,
                      // color: selectedIndex == 3 ? ColorManager.naviBlue : ColorManager.grey,
                      height: 26,
                    ),
                  ),
                  activeIcon: Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: SvgPicture.asset(
                      SvgString.active_settings,
                      height: 26,
                    ),
                  ),
                ),
              ],
              onTap: onItemTapped,
            ),
          ),
        ),
      ),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      // _pageController!.animateToPage(index,
      //     duration: const Duration(milliseconds:500), curve: Curves.linear,);
    });
  }
}
