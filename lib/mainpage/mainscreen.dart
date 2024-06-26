// ignore_for_file: file_names, no_logic_in_create_state, invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member, deprecated_member_use, library_private_types_in_public_api

import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:demoapp/dashboard_pages/dashboard.dart';
import 'package:demoapp/dashboard_pages/notification.dart';
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

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
        systemNavigationBarColor: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<TabItem> tabItems = List.of(
      [
        TabItem(
          Icons.home_filled,
          "Home",
          Colors.green.shade100,
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.green.shade800,
          ),
        ),
        TabItem(
          Icons.shopping_basket,
          "Cart",
          Colors.green.shade100,
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.green.shade800,
          ),
        ),
        TabItem(
          Icons.notifications,
          "Notifications",
          Colors.green.shade100,
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.green.shade800,
          ),
        ),
        TabItem(
          Icons.settings,
          "Settings",
          Colors.green.shade100,
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.green.shade800,
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
          title: Center(
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(
                    12.0,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Image.asset(
                      "assets/images/logo_icon.jpg",
                      width: 30.0,
                      height: 30.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12.0,
                ),
                const AnimationText(title: "Biomed Manthan"),
              ],
            ),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: Colors.green.shade200,
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
            BoxShadow(
              color: Colors.black12,
              blurRadius: 15.0,
            ),
          ],
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
      duration: const Duration(milliseconds: 1500),
    );
    _animation = Tween<Offset>(
      begin: const Offset(0.0, -1.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.ease,
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
