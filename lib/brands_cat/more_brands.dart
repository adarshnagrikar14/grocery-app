import 'package:demoapp/brands_cat/dinearth.dart';
import 'package:demoapp/dashboard_pages/search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MoreBrandsPage extends StatefulWidget {
  const MoreBrandsPage({super.key});

  @override
  State<MoreBrandsPage> createState() => _MoreBrandsPageState();
}

class _MoreBrandsPageState extends State<MoreBrandsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("More Brands"),
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 15.0,
                left: 12.0,
                bottom: 10.0,
              ),
              child: Text(
                "Brand Categories",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  fontFamily: GoogleFonts.tiltNeon().fontFamily,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                left: 12.0,
                right: 12.0,
              ),
              child: Card(
                color: Colors.white,
                elevation: 2.0,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: const EdgeInsets.only(
                          top: 20.0,
                          bottom: 15.0,
                          left: 10.0,
                        ),
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            10.0,
                          ),
                          color: Colors.black26,
                        ),
                        height: 55.0,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DineEarthPage(),
                              ),
                            );
                          },
                          child: Image.asset(
                            'assets/images/dinearth.webp',
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: const EdgeInsets.only(
                          top: 20.0,
                          bottom: 15.0,
                          left: 10.0,
                        ),
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            10.0,
                          ),
                          color: Colors.black26,
                        ),
                        height: 55.0,
                        child: GestureDetector(
                          onTap: () {},
                          child: Image.asset(
                            'assets/images/pmahal.png',
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: const EdgeInsets.only(
                          top: 20.0,
                          bottom: 15.0,
                          left: 10.0,
                          right: 12.0,
                        ),
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            10.0,
                          ),
                          color: Colors.black26,
                        ),
                        height: 55.0,
                        child: GestureDetector(
                          onTap: () {},
                          child: Image.asset(
                            'assets/images/kafka.png',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 15.0,
                left: 12.0,
                bottom: 10.0,
              ),
              child: Text(
                "Brand Categories",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  fontFamily: GoogleFonts.tiltNeon().fontFamily,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                left: 12.0,
                right: 12.0,
              ),
              child: Card(
                color: Colors.white,
                elevation: 2.0,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: const EdgeInsets.only(
                          top: 20.0,
                          bottom: 15.0,
                          left: 10.0,
                        ),
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            10.0,
                          ),
                          color: Colors.black26,
                        ),
                        // width: 110.0,
                        height: 55.0,
                        child: GestureDetector(
                          onTap: () {},
                          child: Image.asset(
                            'assets/images/kafka.png',
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: const EdgeInsets.only(
                          top: 20.0,
                          bottom: 15.0,
                          left: 10.0,
                        ),
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            10.0,
                          ),
                          color: Colors.black26,
                        ),
                        // width: 110.0,
                        height: 55.0,
                        child: GestureDetector(
                          onTap: () {},
                          child: Image.asset(
                            'assets/images/dinearth.webp',
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: const EdgeInsets.only(
                          top: 20.0,
                          bottom: 15.0,
                          left: 10.0,
                          right: 12.0,
                        ),
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            10.0,
                          ),
                          color: Colors.black26,
                        ),
                        // width: 110.0,
                        height: 55.0,
                        child: GestureDetector(
                          onTap: () {},
                          child: Image.asset(
                            'assets/images/pmahal.png',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 15.0,
                left: 12.0,
                bottom: 10.0,
              ),
              child: Text(
                "Brand Categories",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  fontFamily: GoogleFonts.tiltNeon().fontFamily,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                left: 12.0,
                right: 12.0,
              ),
              child: Card(
                color: Colors.white,
                elevation: 2.0,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: const EdgeInsets.only(
                          top: 20.0,
                          bottom: 15.0,
                          left: 10.0,
                        ),
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            10.0,
                          ),
                          color: Colors.black26,
                        ),
                        // width: 110.0,
                        height: 55.0,
                        child: GestureDetector(
                          onTap: () {},
                          child: Image.asset(
                            'assets/images/pmahal.png',
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: const EdgeInsets.only(
                          top: 20.0,
                          bottom: 15.0,
                          left: 10.0,
                        ),
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            10.0,
                          ),
                          color: Colors.black26,
                        ),
                        // width: 110.0,
                        height: 55.0,
                        child: GestureDetector(
                          onTap: () {},
                          child: Image.asset(
                            'assets/images/kafka.png',
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: const EdgeInsets.only(
                          top: 20.0,
                          bottom: 15.0,
                          left: 10.0,
                          right: 12.0,
                        ),
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            10.0,
                          ),
                          color: Colors.black26,
                        ),
                        // width: 110.0,
                        height: 55.0,
                        child: GestureDetector(
                          onTap: () {},
                          child: Image.asset(
                            'assets/images/pmahal.png',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 15.0,
                left: 12.0,
                bottom: 10.0,
              ),
              child: Text(
                "Brand Categories",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  fontFamily: GoogleFonts.tiltNeon().fontFamily,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                left: 12.0,
                right: 12.0,
              ),
              child: Card(
                color: Colors.white,
                elevation: 2.0,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: const EdgeInsets.only(
                          top: 20.0,
                          bottom: 15.0,
                          left: 10.0,
                        ),
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            10.0,
                          ),
                          color: Colors.black26,
                        ),
                        // width: 110.0,
                        height: 55.0,
                        child: GestureDetector(
                          onTap: () {},
                          child: Image.asset(
                            'assets/images/dinearth.webp',
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: const EdgeInsets.only(
                          top: 20.0,
                          bottom: 15.0,
                          left: 10.0,
                        ),
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            10.0,
                          ),
                          color: Colors.black26,
                        ),
                        // width: 110.0,
                        height: 55.0,
                        child: GestureDetector(
                          onTap: () {},
                          child: Image.asset(
                            'assets/images/pmahal.png',
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: const EdgeInsets.only(
                          top: 20.0,
                          bottom: 15.0,
                          left: 10.0,
                          right: 12.0,
                        ),
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            10.0,
                          ),
                          color: Colors.black26,
                        ),
                        // width: 110.0,
                        height: 55.0,
                        child: GestureDetector(
                          onTap: () {},
                          child: Image.asset(
                            'assets/images/dinearth.webp',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
