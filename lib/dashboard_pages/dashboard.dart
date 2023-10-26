import 'package:carousel_slider/carousel_slider.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:demoapp/brands_cat/dinearth.dart';
import 'package:demoapp/cust_card_row.dart';
import 'package:demoapp/dashboard_pages/search.dart';
import 'package:demoapp/display_items.dart';
import 'package:demoapp/more_brands.dart';
import 'package:demoapp/types/plates.dart';
import 'package:demoapp/types/container.dart';
import 'package:demoapp/types/tissues.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../show_more_af_2.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<String> selectedItems = [];

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
    "https://img.freepik.com/free-photo/top-view-delicious-squash-meal-with-fresh-red-dogwoods-tomatoes-grey-surface_140725-90400.jpg?size=626&ext=jpg&uid=R39764193&ga=GA1.2.934500188.1688583517&semt=sph",
    "https://img.freepik.com/free-photo/flat-lay-organic-vegetables-with-plate-cutlery_23-2148853372.jpg?w=1060&t=st=1696751314~exp=1696751914~hmac=0b14979fcc37b56fbc68a0be107a2e606b0cf2fe9ff89c7865e24d57e68f070a",
    "https://img.freepik.com/free-photo/top-view-table-arrangement-with-empty-dishes-tableware_23-2150310715.jpg?t=st=1696751332~exp=1696754932~hmac=9c00c291ce02f3620173807b03450408387ade102d765b3695f6170ebbe8d536&w=1060",
    "https://img.freepik.com/free-photo/top-view-brown-wooden-desk_140725-79653.jpg?w=1060&t=st=1696751464~exp=1696752064~hmac=190167f612d985d4c29a36752626f8026be96a21510dfbbc3238b00d5f6984fd"
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
                                      fit: BoxFit.cover,
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
                // items
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
                                    imageUrl: "assets/images/plate.png",
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
                                    imageUrl: "assets/images/tissues.png",
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
                                    imageUrl: "assets/images/containers.png",
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
                                    imageUrl: "assets/images/toothpicks.png",
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
                                      imageUrl: "assets/images/cuttlery.png",
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

                // brand categories
                Container(
                  width: MediaQuery.of(context).size.width,
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
                    top: 22.0,
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
                          "Brand Categories",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            fontFamily: GoogleFonts.tiltNeon().fontFamily,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 0.0, bottom: 10.0),
                        child: Row(
                          children: [
                            Expanded(
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
                                width: 110.0,
                                height: 55.0,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const DineEarthPage(),
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
                              child: Container(
                                margin: const EdgeInsets.only(
                                  top: 20.0,
                                  bottom: 15.0,
                                  left: 15.0,
                                ),
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    10.0,
                                  ),
                                  color: Colors.black26,
                                ),
                                width: 110.0,
                                height: 55.0,
                                child: GestureDetector(
                                  onTap: () {
                                    Fluttertoast.showToast(
                                      msg: "Under development",
                                    );
                                  },
                                  child: Image.asset(
                                    'assets/images/pmahal.png',
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(
                                  top: 20.0,
                                  bottom: 15.0,
                                  left: 15.0,
                                  right: 15.0,
                                ),
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    10.0,
                                  ),
                                  color: Colors.white30,
                                ),
                                width: 110.0,
                                height: 55.0,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const MoreBrandsPage(),
                                      ),
                                    );
                                  },
                                  child: const Center(
                                    child: Text(
                                      "See All",
                                      style: TextStyle(
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
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
                    // color: Colors.green.shade100,
                  ),
                  child: const SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        CustomCardRow(
                          assetUrl: "assets/images/raw1.jpg",
                          title: "Product 1: plate cardboard",
                        ),
                        CustomCardRow(
                          assetUrl: "assets/images/raw2.jpg",
                          title: "Product 2: plate cardboard",
                        ),
                        CustomCardRow(
                          assetUrl: "assets/images/tissue4.jpg",
                          title: "Product 3: Tissue General",
                        ),
                        CustomCardRow(
                          assetUrl: "assets/images/tissue3.jpg",
                          title: "Product 4: Tissue General",
                        ),
                      ],
                    ),
                  ),
                ),

                // show more : featured
                RoundedBorderButton(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ShowProductAll2(),
                        // builder: (context) => const ShowProductAll(),
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
                    // color: Colors.amber.shade300,
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        CustomCardRow(
                          assetUrl: "assets/images/cont1.jpg",
                          title:
                              "${selectedItems.isNotEmpty ? selectedItems[0] : "None"} 1: Product",
                        ),
                        CustomCardRow(
                          assetUrl: "assets/images/raw4.jpg",
                          title:
                              "${selectedItems.isNotEmpty ? selectedItems[0] : "None"} 2: Product",
                        ),
                        CustomCardRow(
                          assetUrl: "assets/images/raw3.jpg",
                          title:
                              "${selectedItems.isNotEmpty ? selectedItems[0] : "None"} 3: Product",
                        ),
                        CustomCardRow(
                          assetUrl: "assets/images/tissue2.jpg",
                          title:
                              "${selectedItems.isNotEmpty ? selectedItems[0] : "None"} 4: Product",
                        ),
                      ],
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
                        CustomCardRow(
                          assetUrl: "assets/images/cont4.jpg",
                          title: "Innovation 1: Product",
                        ),
                        CustomCardRow(
                          assetUrl: "assets/images/cont2.jpg",
                          title: "Innovation 2: Product",
                        ),
                        CustomCardRow(
                          assetUrl: "assets/images/tissue1.jpg",
                          title: "Innovation 3: Product",
                        ),
                        CustomCardRow(
                          assetUrl: "assets/images/raw2.jpg",
                          title: "Innovation 4: Product",
                        ),
                      ],
                    ),
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(
                    top: 30,
                  ),
                  width: MediaQuery.of(context).size.width,
                  // color: Colors.green.shade50,
                  height: 380.0,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Stack(
                      children: [
                        const SizedBox(
                          height: 380.0,
                          child: Image(
                            image: AssetImage(
                              "assets/images/liveitup.jpg",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Live\nit up!",
                                style: TextStyle(
                                  fontSize: 80.0,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.grey.shade700,
                                  height: 1.2,
                                ),
                                textAlign: TextAlign.start,
                              ),
                              const Text(
                                "\nCrafted especially for your Convenience",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black54,
                                  height: 1.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 70.0,
                )
              ],
            ),
          ),
          Positioned(
            bottom: 100.0,
            right: 20.0,
            child: Column(
              children: [
                FloatingActionButton(
                  onPressed: () async {
                    if (!await launchUrl(Uri.parse("tel:9168202971"))) {
                      throw Exception('Could not launch');
                    }
                  },
                  backgroundColor: Colors.green.shade50,
                  child: const Icon(Icons.call),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                FloatingActionButton(
                  onPressed: () {
                    _launchUrl();
                  },
                  backgroundColor: Colors.green.shade50,
                  child: Image.asset(
                    "assets/images/what.png",
                    width: 30.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(Uri.parse("https://wa.me/919168202971"))) {
      throw Exception('Could not launch');
    }
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
                color: Colors.black,
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
