import 'package:carousel_slider/carousel_slider.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:demoapp/display_items.dart';
import 'package:demoapp/types/plates.dart';
import 'package:demoapp/types/container.dart';
import 'package:demoapp/types/tissues.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<String> selectedItems = [];

  @override
  void initState() {
    super.initState();

    selectedItems = [options[0]];
  }

  List<String> options = [
    "Affordable",
    "Reasonable",
    "Premium",
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // corousel image slider
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 200.0,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                  enlargeStrategy: CenterPageEnlargeStrategy.scale,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 2),
                ),
                items: imageUrls.map(
                  (imageUrl) {
                    return Builder(
                      builder: (BuildContext context) {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Image.network(
                              imageUrl,
                              width: 300.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ).toList(),
              ),
            ),
            // categories
            const Padding(
              padding: EdgeInsets.only(
                top: 30.0,
                left: 25.0,
              ),
              child: Text(
                "Categories",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0,
                ),
              ),
            ),
            // items
            SingleChildScrollView(
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
                          left: 18.0,
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
                          left: 18.0,
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
                                  const ContainerPage(type: "Containers"),
                            ),
                          );
                        },
                        size: 55,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          top: 7.0,
                          left: 18.0,
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
                                  const PlatesPage(type: "Toothpicks"),
                            ),
                          );
                        },
                        size: 55,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          top: 7.0,
                          left: 18.0,
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
                                    const PlatesPage(type: "Cuttlery"),
                              ),
                            );
                          },
                          size: 55,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                            top: 7.0,
                            left: 18.0,
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
            // title 2
            const Padding(
              padding: EdgeInsets.only(
                top: 25.0,
                left: 25.0,
              ),
              child: Text(
                "Featured products for you",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0,
                ),
              ),
            ),

            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomCard(
                  assetUrl: "assets/images/raw1.jpg",
                  title: "Product 1: plate cardboard",
                ),
                CustomCard(
                  assetUrl: "assets/images/raw2.jpg",
                  title: "Product 2: plate cardboard",
                ),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomCard(
                  assetUrl: "assets/images/tissue4.jpg",
                  title: "Product 3: Tissue General",
                ),
                CustomCard(
                  assetUrl: "assets/images/tissue3.jpg",
                  title: "Product 4: Tissue General",
                ),
              ],
            ),

            // show more : featured
            RoundedBorderButton(
              onTap: () {},
              text: "Show More",
            ),

            // categories
            const Padding(
              padding: EdgeInsets.only(
                top: 30.0,
                left: 20.0,
              ),
              child: Text(
                "Refined Selections",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0,
                ),
              ),
            ),

            // chips
            Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
                left: 2.0,
              ),
              child: ChipsChoice<String>.single(
                value: selectedItems.isNotEmpty ? selectedItems[0] : null,
                onChanged: (val) {
                  setState(() {
                    selectedItems = [val];
                  });
                },
                choiceItems: C2Choice.listFrom<String, String>(
                  source: options,
                  value: (i, v) => v,
                  label: (i, v) => v,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
              ),
              child: Text(
                "Showing some refined ${selectedItems.isNotEmpty ? selectedItems[0] : "None"} products",
                style: const TextStyle(
                  fontSize: 14.0,
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomCard(
                  assetUrl: "assets/images/raw3.jpg",
                  title:
                      "${selectedItems.isNotEmpty ? selectedItems[0] : "None"} 1: Product",
                ),
                CustomCard(
                  assetUrl: "assets/images/raw4.jpg",
                  title:
                      "${selectedItems.isNotEmpty ? selectedItems[0] : "None"} 2: Product",
                ),
              ],
            ),

            // categories
            const Padding(
              padding: EdgeInsets.only(
                top: 30.0,
                left: 20.0,
              ),
              child: Text(
                "Our innovations",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0,
                ),
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(
                left: 20.0,
                top: 15.0,
                right: 10.0,
              ),
              child: Text(
                "Showing some of our innovated products handcrafted for your selection",
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
            ),

            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomCard(
                  assetUrl: "assets/images/cont2.jpg",
                  title: "Handcrafted 1: Product",
                ),
                CustomCard(
                  assetUrl: "assets/images/cont3.jpg",
                  title: "Handcrafted 2: Product",
                ),
              ],
            ),

            // space bottom
            const SizedBox(
              height: 130.0,
            ),
          ],
        ),
      ),
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
              ),
            ),
          );
        },
        child: Card(
          color: Colors.white,
          elevation: 0.7,
          margin: const EdgeInsets.only(
            left: 10.0,
            right: 10.0,
            top: 20.0,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
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
