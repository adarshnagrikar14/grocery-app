import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demoapp/cust_cards/cust_card_row.dart';
import 'package:demoapp/dashboard_pages/search.dart';
import 'package:demoapp/display/display_items.dart';
import 'package:demoapp/types/plates.dart';
import 'package:demoapp/types/container.dart';
import 'package:demoapp/types/tissues.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:demoapp/cust_cards/cust_card_linear_mainpage.dart';

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
    selectedItems = [options[0]];
  }

  List<String> options = [
    "All",
    "Affordable",
    "Reasonable",
    "Premium\n",
  ];

  List<String> imageUrls = [
    "https://img.freepik.com/free-vector/flat-design-food-sale-background_23-2149219274.jpg?t=st=1717073699~exp=1717077299~hmac=153bd6bb5225d93c2c8ae2c0e1945fdecef53d8d1dafd242f1c0e9cf6485ac03&w=1380",
    "https://img.freepik.com/free-vector/flat-design-food-facebook-ad_23-2149219269.jpg?t=st=1717073757~exp=1717077357~hmac=370c8a6ab0b2f1f13ef290c53fd06d1c888a52c712a73ed371598f6bea8d1170&w=1060",
    "https://img.freepik.com/free-vector/hand-drawn-supermarket-facebook-cover_23-2150389222.jpg?t=st=1717073849~exp=1717077449~hmac=5c1b73382e1e719f30b0542e06e8ae6027198bc146f915a6a12933bcc0f3135a&w=1380",
    "https://img.freepik.com/free-psd/flat-design-natural-market-facebook-template_23-2149701901.jpg?t=st=1717073871~exp=1717077471~hmac=1c168e1319f1810bc0c0cd4825d1476c4472cd31a094864c337674da3268adb3&w=1380"
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

                // categories
                Container(
                  // color: Colors.grey,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      12.0,
                    ),
                    color: Colors.green.shade100,
                  ),
                  margin: const EdgeInsets.only(
                    left: 18.0,
                    right: 18.0,
                    top: 15.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 8.0,
                          left: 10.0,
                        ),
                        child: Text(
                          "Categories",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            fontFamily: GoogleFonts.tiltNeon().fontFamily,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 0.0, bottom: 10.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  RoundedImage(
                                    imageUrl: "assets/images/oil.jpg",
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const PlatesPage(type: "Plates"),
                                        ),
                                      );
                                    },
                                    size: 55,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(
                                      top: 7.0,
                                      left: 8.0,
                                    ),
                                    child: SizedBox(
                                      width: 60.0,
                                      child: Center(
                                        child: Text(
                                          "Plates",
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  RoundedImage(
                                    imageUrl: "assets/images/oil.jpg",
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const TissuePage(type: "Tissues"),
                                        ),
                                      );
                                    },
                                    size: 55,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(
                                      top: 7.0,
                                      left: 8.0,
                                    ),
                                    child: SizedBox(
                                      width: 60.0,
                                      child: Center(
                                        child: Text(
                                          "Tissues",
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  RoundedImage(
                                    imageUrl: "assets/images/oil.jpg",
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const ContainerPage(
                                                  type: "Containers"),
                                        ),
                                      );
                                    },
                                    size: 55,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(
                                      top: 7.0,
                                      left: 8.0,
                                    ),
                                    child: SizedBox(
                                      width: 60.0,
                                      child: Center(
                                        child: Text(
                                          "Containers",
                                          style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  RoundedImage(
                                    imageUrl: "assets/images/oil.jpg",
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const PlatesPage(
                                                  type: "Toothpicks"),
                                        ),
                                      );
                                    },
                                    size: 55,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(
                                      top: 7.0,
                                      left: 8.0,
                                    ),
                                    child: SizedBox(
                                      width: 60.0,
                                      child: Center(
                                        child: Text(
                                          "Toothpicks",
                                          style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: Column(
                                  children: [
                                    RoundedImage(
                                      imageUrl: "assets/images/oil.jpg",
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const PlatesPage(
                                                    type: "Cuttlery"),
                                          ),
                                        );
                                      },
                                      size: 55,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(
                                        top: 7.0,
                                        left: 8.0,
                                      ),
                                      child: SizedBox(
                                        width: 60.0,
                                        child: Center(
                                          child: Text(
                                            "Cuttlery",
                                            style: TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // title 2
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
                    "Featured Products for You",
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
                  child: const FeaturedItems(),
                ),

                // show more : featured
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
                    "Refined Selections",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      fontFamily: GoogleFonts.tiltNeon().fontFamily,
                    ),
                  ),
                ),

                // chips
                Padding(
                  padding: const EdgeInsets.only(
                    top: 2.0,
                    left: 2.0,
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.centerLeft,
                    child: ChipsChoice<String>.single(
                      value: selectedItems.isNotEmpty ? selectedItems[0] : null,
                      onChanged: (val) {
                        setState(() {
                          selectedItems = [val];
                        });
                      },
                      choiceStyle: C2ChipStyle.filled(
                        color: Colors.black12,
                        checkmarkColor: Colors.green.shade900,
                        selectedStyle: C2ChipStyle.filled(
                          color: Colors.green.shade100,
                        ),
                      ),
                      choiceCheckmark: true,
                      choiceItems: C2Choice.listFrom<String, String>(
                        source: options,
                        value: (i, v) => v,
                        label: (i, v) => v,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    bottom: 8.0,
                  ),
                  child: Text(
                    "Showing some refined ${selectedItems.isNotEmpty ? selectedItems[0] : "None"} products",
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      12.0,
                    ),
                  ),
                  child: const SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [],
                    ),
                  ),
                ),

                // categories
                const Space(
                  top: 22,
                  bottom: 0,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 15.0,
                    left: 20.0,
                  ),
                  child: Text(
                    "Our Innovations",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      fontFamily: GoogleFonts.tiltNeon().fontFamily,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(
                    left: 12.0,
                    top: 15.0,
                    right: 12.0,
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
                        "Showing some of our innovated products handcrafted for your selection",
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
                    top: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      12.0,
                    ),
                    // color: Colors.amber.shade300,
                  ),
                  child: const SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        // CustomCardRow(
                        //   assetUrl: "assets/images/cont4.jpg",
                        //   title: "Innovation 1: Product",
                        // ),
                        // CustomCardRow(
                        //   assetUrl: "assets/images/cont2.jpg",
                        //   title: "Innovation 2: Product",
                        // ),
                        // CustomCardRow(
                        //   assetUrl: "assets/images/tissue1.jpg",
                        //   title: "Innovation 3: Product",
                        // ),
                        // CustomCardRow(
                        //   assetUrl: "assets/images/raw2.jpg",
                        //   title: "Innovation 4: Product",
                        // ),
                      ],
                    ),
                  ),
                ),

                const Space(
                  top: 22,
                  bottom: 0,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 15.0,
                    left: 20.0,
                  ),
                  child: Text(
                    "Launches you would Love",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      fontFamily: GoogleFonts.tiltNeon().fontFamily,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(
                    left: 12.0,
                    top: 15.0,
                    right: 12.0,
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
                        "Showing some of Our hot launches to fulfill what you want.",
                        style: TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ),
                ),

                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    final assetUrl = product['ImageLink'] ?? '';
                    final title = product['ProductName'] ?? '';
                    final type = product['ProductType'] ?? '';
                    final productID = product['ProductId'] ?? "";

                    List<String> desc = [
                      "Our Plate Cardboard is more than just a serving solution; it's your sustainable partner. Crafted from durable materials, it's designed to withstand the weight of your favorite dishes while being environmentally conscious. Choose it for a guilt-free dining experience that's both robust and eco-friendly.",
                      "Our Tissue General offers the perfect blend of resilience and responsibility. With excellent absorbency and strength, it tackles spills and messes effectively. Plus, it's an eco-friendly choice, crafted from sustainable materials to help maintain hygiene while preserving the planet.",
                      "Our Container is not just for storing your meals; it's designed to last. Its sturdy construction ensures that your food remains fresh, safe, and secure. What's more, it's an eco-conscious choice, made from sustainable materials, so you can savor your meals knowing you're making a responsible choice for the environment",
                      "Our Toothpicks are more than just handy tools; they're crafted to withstand the rigors of daily use. Their sturdiness makes them perfect for a variety of tasks. In addition to durability, they are made from sustainable materials, combining strength with eco-friendliness to meet your needs while caring for the planet.",
                    ];

                    final random = Random();
                    int randomIndex = random.nextInt(desc.length);

                    return CustomCardMain(
                      assetUrl: assetUrl,
                      title: title,
                      productType: type,
                      productID: productID,
                      description: desc[randomIndex],
                    );
                  },
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
  const FeaturedItems({Key? key}) : super(key: key);

  Future<List<Map<String, dynamic>>> fetchFeaturedItems() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Featured').get();
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
          return const Center(child: CircularProgressIndicator());
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
        top: 28.0,
        left: 10.0,
        right: 10.0,
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
          backgroundColor: Colors.white,
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

class CustomCard extends StatelessWidget {
  final String assetUrl;
  final String title;

  const CustomCard({
    required this.assetUrl,
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DisplayItemPage(
                imageUrl: assetUrl,
                productName: title,
                desc: "Description",
              ),
            ),
          );
        },
        child: Card(
          color: Colors.white,
          elevation: 0.7,
          margin: const EdgeInsets.only(
            left: 10.0,
            top: 20.0,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.asset(
                    assetUrl,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.",
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.black87,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ),
        ),
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
                color: Colors.white,
              ),
              color: Colors.grey.shade100,
            ),
            child: imageUrl.contains("assets")
                ? Image.asset(
                    imageUrl,
                    width: size,
                    height: size,
                    fit: BoxFit.cover,
                  )
                : Image.network(
                    imageUrl,
                    width: size,
                    height: size,
                    fit: BoxFit.cover,
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
