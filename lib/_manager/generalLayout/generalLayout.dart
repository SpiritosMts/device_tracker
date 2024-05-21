
import 'dart:collection';

import 'package:device_track/screens/graph.dart';
import 'package:device_track/screens/notifications.dart';
import 'package:device_track/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../screens/dashboard.dart';
import '../../screens/map_screen.dart';
import '../bindings.dart';
import '../styles.dart';
import 'generalLayoutCtr.dart';


class GeneralLayout extends StatefulWidget {
  const GeneralLayout({super.key});

  @override
  State<GeneralLayout> createState() => _GeneralLayoutState();
}

class _GeneralLayoutState extends State<GeneralLayout> {

  @override
  void initState() {
    super.initState();
    Future.delayed( Duration(milliseconds: 0), () {

    });
  }

  List<Widget> _buildScreens() {
    return [
      Dashboard(),
      Graph(),
      MapScreen(),
      Notifications(),
      SettingsView(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: ("Dashboard"),

        activeColorPrimary: navBarActive,
        inactiveColorPrimary: navBarDesactive,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.auto_graph),
        title: ("Graph"),

        activeColorPrimary: navBarActive,
        inactiveColorPrimary: navBarDesactive,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(LineIcons.map),
        title: ("Map"),
        activeColorPrimary: navBarActive,
        inactiveColorPrimary: navBarDesactive,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.notifications),
        title: ("Notifications"),
        activeColorPrimary: navBarActive,
        inactiveColorPrimary: navBarDesactive,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.settings),
        title: ("Settings"),
        activeColorPrimary: navBarActive,
        inactiveColorPrimary: navBarDesactive,
      ),
    ];
  }



  /// **************************************************************************************
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LayoutCtr>(
        initState: (_) {
          layCtr.onScreenSelected(0);
        },
        dispose: (_) {},
      builder: (_) {
        return Scaffold(
          appBar:
          AppBar(
            centerTitle: true,
            backgroundColor: appBarBgColor,
            bottom: appBarUnderline(),

            title: Text(
              layCtr.appBarText.tr,style: TextStyle(
              fontWeight: FontWeight.w500,
              color: appBarTitleColor,
             ),
            ),

            leading: layCtr.leading,
            actions: layCtr.appBarBtns,
          ),

          body: PersistentTabView(

            selectedTabScreenContext: (ctx){

            },
            context,
            controller: authCtr.layoutViewCtr,
            screens: _buildScreens(),
            items: _navBarsItems(),
            backgroundColor: navBarBgColor,
            onItemSelected:layCtr.onScreenSelected,

            decoration: NavBarDecoration(
              borderRadius: BorderRadius.circular(10.0),
              colorBehindNavBar: Colors.white,
            ),
            popActionScreens: PopActionScreensType.all,

            itemAnimationProperties: ItemAnimationProperties(
              // Navigation Bar's items animation properties.
              duration: Duration(milliseconds: 200),
              curve: Curves.ease,
            ),
            screenTransitionAnimation: ScreenTransitionAnimation(
              // Screen transition animation on change of selected tab.
              animateTabTransition: true,
              curve: Curves.ease,
              duration: Duration(milliseconds: 200),
            ),
            bottomScreenMargin: 55,
            navBarHeight: 55,

            navBarStyle: NavBarStyle.style1, // Choose the nav bar style with this property.
          ),
        );
      }
    );
  }
}
