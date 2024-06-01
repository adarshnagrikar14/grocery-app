import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demoapp/cust_cards/cust_card_row.dart';
import 'package:demoapp/dashboard_pages/search.dart';
import 'package:demoapp/featured_items.dart';
import 'package:demoapp/featureditems.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../show_more/show_more_af_2.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<String> selectedItems = [];

  List<Map<String, dynamic>> products = [];

  int selectedImageCarousel = 0;

  @override
  void initState() {
    super.initState();

    selectedImageCarousel = 0;
  }

  List<String> imageUrls = [
    "https://firebasestorage.googleapis.com/v0/b/grocery-app-e599b.appspot.com/o/b2.jpg?alt=media&token=8aff418d-6666-4cb8-99c9-11458976b4b1",
    "https://firebasestorage.googleapis.com/v0/b/grocery-app-e599b.appspot.com/o/b3.jpg?alt=media&token=b04908ad-4c37-4d86-bb61-6efba038fa34",
    "https://firebasestorage.googleapis.com/v0/b/grocery-app-e599b.appspot.com/o/b1.jpg?alt=media&token=4afe2f48-7ed0-4dfa-8be0-6ccd0b287c3e",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    top: 15.0,
                    left: 15.0,
                    right: 15.0,
                    bottom: 20.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      12.0,
                    ),
                    color: Colors.grey.shade200,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 12.0,
                      bottom: 12.0,
                      left: 13.0,
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SearchPage(),
                          ),
                        );
                      },
                      child: const Row(
                        children: [
                          Icon(
                            Icons.search_rounded,
                            size: 30.0,
                          ),
                          SizedBox(
                            width: 25.0,
                          ),
                          Text(
                            "Search here...",
                            style: TextStyle(
                              fontSize: 17.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // corousel image slider
                Padding(
                  padding: const EdgeInsets.only(
                    left: 18.0,
                  ),
                  child: Text(
                    "Highlights",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      fontFamily: GoogleFonts.tiltNeon().fontFamily,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Column(
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                          height: 200.0,
                          aspectRatio: 16 / 9,
                          enlargeCenterPage: true,
                          enlargeFactor: 1,
                          enlargeStrategy: CenterPageEnlargeStrategy.scale,
                          autoPlay: false,
                          autoPlayInterval: const Duration(seconds: 3),
                          enableInfiniteScroll: false,
                          viewportFraction: 1,
                          onPageChanged: (index, reason) {
                            setState(() {
                              selectedImageCarousel = index;
                            });
                          },
                        ),
                        items: imageUrls.map(
                          (imageUrl) {
                            return Builder(
                              builder: (BuildContext context) {
                                return SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.92,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15.0),
                                    child: Image.network(
                                      imageUrl,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ).toList(),
                      ),
                      const SizedBox(
                        height: 18.0,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(
                          imageUrls.length,
                          (index) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            width: 10.0,
                            height: 10.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: selectedImageCarousel == index
                                  ? Colors.blue
                                  : Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const Space(
                  top: 20,
                  bottom: 0,
                ),
                const FeaturedItems3(),

                const Space(
                  top: 22,
                  bottom: 0,
                ),
                const FeaturedItems2(),

                const Space(
                  top: 22,
                  bottom: 0,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 25.0,
                    left: 25.0,
                  ),
                  child: Text(
                    "Featured Instruments for You",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      fontFamily: GoogleFonts.tiltNeon().fontFamily,
                    ),
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: 10,
                  ),
                  padding: const EdgeInsets.only(
                    bottom: 5.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      12.0,
                    ),
                  ),
                  child: const FeaturedItems(
                    category: "Featured",
                  ),
                ),

                RoundedBorderButton(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ShowProductAll2(),
                      ),
                    );
                  },
                  text: "Show More",
                ),

                // categories
                const Space(
                  top: 22,
                  bottom: 0,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                    left: 20.0,
                  ),
                  child: Text(
                    "Picked for you...",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      fontFamily: GoogleFonts.tiltNeon().fontFamily,
                    ),
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: 10,
                  ),
                  padding: const EdgeInsets.only(
                    bottom: 5.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      12.0,
                    ),
                  ),
                  child: const FeaturedItems(
                    category: "Fresh",
                  ),
                ),
                const Space(
                  top: 20,
                  bottom: 0,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 15.0,
                    left: 20.0,
                  ),
                  child: Text(
                    "More to Explore",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      fontFamily: GoogleFonts.tiltNeon().fontFamily,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(
                    left: 18.0,
                    top: 10.0,
                    right: 18.0,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        8.0,
                      ),
                      border: Border.all(
                        color: Colors.black38,
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(
                        8.0,
                      ),
                      child: Text(
                        "See, Pick and Purchase more of our product range available for you.",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    bottom: 130,
                    top: 10,
                  ),
                  padding: const EdgeInsets.only(
                    bottom: 5.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      12.0,
                    ),
                  ),
                  child: const FeaturedItems(category: "More"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FeaturedItems extends StatelessWidget {
  final String category;
  const FeaturedItems({Key? key, required this.category}) : super(key: key);

  Future<List<Map<String, dynamic>>> fetchFeaturedItems() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection(category).get();
    return querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchFeaturedItems(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.green,
          ));
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No items found.'));
        } else {
          final items = snapshot.data!;
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: items.map((item) {
                return CustomCardRow(
                  assetUrl: item['Url'],
                  title: item['Title'],
                  desc: item["Description"],
                );
              }).toList(),
            ),
          );
        }
      },
    );
  }
}

class RoundedBorderButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;

  const RoundedBorderButton({
    Key? key,
    required this.onTap,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20.0,
        left: 14.0,
        right: 14.0,
      ),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          side: BorderSide(
            color: Colors.green.shade300,
            width: MediaQuery.of(context).size.width * 0.002,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          backgroundColor: Colors.green.shade50,
          minimumSize: Size(
            MediaQuery.of(context).size.width,
            50.0,
          ),
        ),
        child: Text(text),
      ),
    );
  }
}

class RoundedImage extends StatelessWidget {
  final String imageUrl;
  final double size;
  final VoidCallback? onTap;

  const RoundedImage({
    Key? key,
    required this.imageUrl,
    required this.size,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20.0,
        right: 10.0,
        left: 20.0,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size / 2),
        child: InkWell(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: 1.2,
                color: Colors.black,
              ),
              color: Colors.grey.shade100,
            ),
            child: imageUrl.contains("assets")
                ? Image.asset(
                    imageUrl,
                    width: size,
                    height: size,
                    fit: BoxFit.fitHeight,
                  )
                : Image.network(
                    imageUrl,
                    width: size,
                    height: size,
                    fit: BoxFit.fitHeight,
                  ),
          ),
        ),
      ),
    );
  }
}

class Space extends StatelessWidget {
  final double top;
  final double bottom;

  const Space({super.key, required this.top, required this.bottom});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: top,
        bottom: bottom,
        left: 18.0,
        right: 18.0,
      ),
      child: SizedBox(
        height: 1.0,
        child: Container(
          color: Colors.grey,
        ),
      ),
    );
  }
}
