// ignore_for_file: file_names, no_logic_in_create_state, invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member, deprecated_member_use, library_private_types_in_public_api

import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:demoapp/dashboard_pages/dashboard.dart';
import 'package:demoapp/dashboard_pages/notification.dart';
import 'package:demoapp/dashboard_pages/settings.dart';
import 'package:demoapp/dashboard_pages/wishlist.dart';
import 'package:demoapp/side_menu/bakers.dart';
import 'package:demoapp/side_menu/bars.dart';
import 'package:demoapp/side_menu/caterers.dart';
import 'package:demoapp/side_menu/hotels.dart';
import 'package:demoapp/side_menu/restaurant.dart';
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
          Icons.favorite_rounded,
          "Wishlist",
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
                const AnimationText(title: "Venus (India) Inc."),
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
        drawer: Drawer(
          backgroundColor: Colors.green.shade50,
          child: ListView(
            children: <Widget>[
              const DrawerHeader(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Explore More",
                      style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "The Specific Collection For Each Category",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          12.0,
                        ),
                        color: Colors.white60,
                      ),
                      margin: const EdgeInsets.only(
                        left: 10.0,
                        top: 20.0,
                        right: 10.0,
                      ),
                      child: ListTile(
                        leading: const Icon(Icons.restaurant),
                        title: const Text("Restaurants"),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RestaurantPage(),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          12.0,
                        ),
                        color: Colors.white60,
                      ),
                      margin: const EdgeInsets.only(
                        left: 10.0,
                        top: 10.0,
                        right: 10.0,
                      ),
                      child: ListTile(
                        leading: const Icon(Icons.local_bar),
                        title: const Text("Bars"),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BarsPage(),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          12.0,
                        ),
                        color: Colors.white60,
                      ),
                      margin: const EdgeInsets.only(
                        left: 10.0,
                        top: 10.0,
                        right: 10.0,
                      ),
                      child: ListTile(
                        leading: const Icon(Icons.hotel),
                        title: const Text("Hotels"),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HotelsPage(),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          12.0,
                        ),
                        color: Colors.white60,
                      ),
                      margin: const EdgeInsets.only(
                        left: 10.0,
                        top: 10.0,
                        right: 10.0,
                      ),
                      child: ListTile(
                        leading: const Icon(Icons.local_pizza),
                        title: const Text("Caterers"),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CaterersPage(),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          12.0,
                        ),
                        color: Colors.white60,
                      ),
                      margin: const EdgeInsets.only(
                        left: 10.0,
                        top: 10.0,
                        right: 10.0,
                      ),
                      child: ListTile(
                        leading: const Icon(Icons.cake),
                        title: const Text("Bakers"),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BakersPage(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
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
