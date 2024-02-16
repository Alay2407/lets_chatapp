import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lets_chatapp/Presentation/screen/call_screen.dart';
import 'package:lets_chatapp/Presentation/screen/contact_screen.dart';
import 'package:lets_chatapp/Presentation/screen/message_screen.dart';
import 'package:lets_chatapp/Presentation/screen/settings_screen.dart';
import 'package:lets_chatapp/core/colors/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  final List<GlobalKey<NavigatorState>> _navigatorKeys = [GlobalKey<NavigatorState>(), GlobalKey<NavigatorState>(), GlobalKey<NavigatorState>(), GlobalKey<NavigatorState>()];

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context, int index) {
    return {
      '/': (context) {
        return [const MessageScreen(), const CallScreen(), const ContactScreen(), const SettingsScreen()].elementAt(index);
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
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab = !await _navigatorKeys[selectedIndex].currentState!.maybePop();

        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              _buildOffstageNavigator(0),
              _buildOffstageNavigator(1),
              _buildOffstageNavigator(2),
              _buildOffstageNavigator(3),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          // selectedItemColor: ColorManager.darkNavy,
          selectedLabelStyle: TextStyle(color: ColorManager.naviBlue),
          type: BottomNavigationBarType.fixed,
          // fixedColor: Colors.grey,
          currentIndex: selectedIndex,
          // unselectedLabelStyle: TextStyle(color: ColorManager.naviBlue),
          // showUnselectedLabels: true,
          unselectedItemColor: ColorManager.grey,
          // elevation: 10,
          items: [
            BottomNavigationBarItem(
              label: "Message",
              icon: SvgPicture.asset(
                'assets/images/Message.svg',
                height: 26,
              ),
              activeIcon: SvgPicture.asset(
                'assets/images/active_Message.svg',
                height: 26,
              ),
            ),
            BottomNavigationBarItem(
              label: "Calls",
              icon: SvgPicture.asset(
                'assets/images/Call.svg',
                height: 26,
              ),
              activeIcon: SvgPicture.asset(
                'assets/images/active_Call.svg',
                height: 26,
              ),
            ),
            BottomNavigationBarItem(
              label: "Contacts",
              icon: SvgPicture.asset(
                'assets/images/user.svg',
                height: 26,
              ),
              activeIcon: SvgPicture.asset(
                'assets/images/active_user.svg',
                height: 26,
              ),
            ),
            BottomNavigationBarItem(
              label: "Settings",
              icon: SvgPicture.asset(
                'assets/images/settings.svg',
                // color: selectedIndex == 3 ? ColorManager.naviBlue : ColorManager.grey,
                height: 26,
              ),
              activeIcon: SvgPicture.asset(
                'assets/images/active_settings.svg',
                height: 26,
              ),
            ),
          ],
          onTap: onItemTapped,
        ),
      ),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      // switch (selectedIndex) {
      //   case 0:
      //     Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) => MessageScreen(),
      //         ));
      //     break;
      //   case 1:
      //     Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) => MessageScreen(),
      //         ));
      //     break;
      //   case 2:
      //     Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) => MessageScreen(),
      //         ));
      //     break;
      // }
    });
  }
}
