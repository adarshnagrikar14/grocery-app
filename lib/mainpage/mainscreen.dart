// ignore_for_file: file_names, no_logic_in_create_state, invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member, deprecated_member_use, library_private_types_in_public_api

import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:demoapp/dashboard_pages/dashboard.dart';
import 'package:demoapp/dashboard_pages/notification.dart';
import 'package:demoapp/dashboard_pages/search.dart';
import 'package:demoapp/dashboard_pages/settings.dart';
import 'package:demoapp/dashboard_pages/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() {
    return _MainScreenState();
  }
}

class _MainScreenState extends State<MainScreen> {
  late int _selectedIndex;

  late CircularBottomNavigationController _navigationController;

  @override
  void initState() {
    super.initState();

    _selectedIndex = 0;
    _navigationController = CircularBottomNavigationController(_selectedIndex);

    // SystemChrome.setSystemUIOverlayStyle(
    //   SystemUiOverlayStyle.light.copyWith(
    //     systemNavigationBarColor: Colors.green.shade100,
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    List<TabItem> tabItems = List.of(
      [
        TabItem(
          Icons.home,
          "Home",
          Colors.green.shade100,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        TabItem(
          Icons.favorite_rounded,
          "Wishlist",
          Colors.green.shade100,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        TabItem(
          Icons.notifications,
          "Notifications",
          Colors.green.shade100,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        TabItem(
          Icons.settings,
          "Settings",
          Colors.green.shade100,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );

    final List widgetOptions = [
      const DashboardScreen(),
      const WishlistPage(),
      const NotificationPage(),
      const SettingsPage()
    ];

    return WillPopScope(
      onWillPop: () async {
        if (_selectedIndex > 0) {
          setState(() {
            _selectedIndex = 0;
            _navigationController.value = 0;
          });

          Navigator.of(context).popUntil((route) => route.isFirst);

          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 70.0,
          title: const AnimationText(title: "Venus (India) Inc."),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18.0,
                vertical: 2.0,
              ),
              child: GestureDetector(
                child: const Tooltip(
                  triggerMode: TooltipTriggerMode.longPress,
                  message: "Search",
                  child: Icon(
                    Icons.search_rounded,
                    size: 30.0,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SearchPage(),
                    ),
                  );
                },
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(
            //     horizontal: 18.0,
            //     vertical: 2.0,
            //   ),
            //   child: GestureDetector(
            //     child: const Tooltip(
            //       triggerMode: TooltipTriggerMode.longPress,
            //       message: "Help",
            //       child: Text("Help"),
            //     ),
            //     onTap: () {},
            //   ),
            // ),
          ],
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.green.shade100,
                  Colors.green.shade50,
                  Colors.green.shade50,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
        body: Container(
          child: widgetOptions.elementAt(_selectedIndex),
        ),
        extendBody: true,
        bottomNavigationBar: CircularBottomNavigation(
          tabItems,
          controller: _navigationController,
          backgroundBoxShadow: const <BoxShadow>[
            BoxShadow(color: Colors.black12, blurRadius: 15.0),
          ],
          // barBackgroundGradient: LinearGradient(
          //   colors: [
          //     Colors.green.shade50,
          //     Colors.green.shade50,
          //     Colors.green.shade100,
          //   ],
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter,
          // ),
          selectedIconColor: Colors.black87,
          selectedPos: _selectedIndex,
          circleSize: 65.0,
          normalIconColor: Colors.black54,
          selectedCallback: (selectedPos) {
            setState(() {
              _selectedIndex = selectedPos!;
            });
          },
          barHeight: 75.0,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _navigationController.dispose();
    super.dispose();
  }
}

class AnimationText extends StatefulWidget {
  final String title;
  const AnimationText({super.key, required this.title});

  @override
  _AnimationTextState createState() => _AnimationTextState();
}

class _AnimationTextState extends State<AnimationText>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );
    _animation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.bounceInOut,
    ));
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: Text(
        widget.title,
        style: const TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
