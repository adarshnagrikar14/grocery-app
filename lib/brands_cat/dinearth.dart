import 'package:chips_choice/chips_choice.dart';
import 'package:demoapp/cust_cards/cust_card_linear.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

import '../dashboard_pages/search.dart';

class DineEarthPage extends StatefulWidget {
  const DineEarthPage({super.key});

  @override
  State<DineEarthPage> createState() => _DineEarthPageState();
}

class _DineEarthPageState extends State<DineEarthPage> {
  // selected filters
  List<String> selectedCost = [];
  List<String> selectedSize = [];
  List<String> selectedColor = [];
  List<String> selectedStyle = [];
  int selectedSort = 0;

  final List<String> optionSort = [
    "All",
    "Newly Launched",
    "Most Popular",
  ];

  List<String> optionCost = [
    "All",
    "Compartment",
    "Round",
    "Square Rectangle",
    "Multipurpose",
    "Takeaway",
  ];

  List<ProductItem> productItemsTemp = [];

  List<ProductItem> productItems = [
    ProductItem(
      imageUrl: "assets/images/DA08.jpg",
      title: "DA08: 10\" 3 Compartment Round Tray",
      type: "Compartment",
      description: "This is a 10\" 3 compartment round tray.",
    ),
    ProductItem(
      imageUrl: "assets/images/DA09.jpg",
      title: "DA09: 11\" 4 Compartment Round Tray",
      type: "Compartment",
      description: "This is an 11\" 4 compartment round tray.",
    ),
    ProductItem(
      imageUrl: "assets/images/DA15.JPG",
      title: "DA15: 5 Compartment School Tray",
      type: "Compartment",
      description: "This is a 5 compartment school tray.",
    ),
    ProductItem(
      imageUrl: "assets/images/DA18.JPG",
      title: "DA18: 12\" 4 Compartment Round Tray",
      type: "Compartment",
      description: "This is a 12\" 4 compartment round tray.",
    ),
    ProductItem(
      imageUrl: "assets/images/DA19.JPG",
      title: "DA19: 9\" 3 Compartment Round Tray",
      type: "Compartment",
      description: "This is a 9\" 3 compartment round tray.",
    ),
    ProductItem(
      imageUrl: "assets/images/DA39.JPG",
      title: "DA39: 6 Compartment Export Meal Tray",
      type: "Compartment",
      description: "This is a 6 compartment export meal tray.",
    ),
    ProductItem(
      imageUrl: "assets/images/DA40.JPG",
      title: "DA40: 7 Compartment Round Tray",
      type: "Compartment",
      description: "This is a 7 compartment round tray.",
    ),
    ProductItem(
      imageUrl: "assets/images/DA41.JPG",
      title: "DA41: 9 Compartment Round Tray",
      type: "Compartment",
      description: "This is a 9 compartment round tray.",
    ),
    ProductItem(
      imageUrl: "assets/images/DA42.JPG",
      title: "DA42: 6 Compartment Meal Tray",
      type: "Compartment",
      description: "This is a 6 compartment meal tray.",
    ),
    ProductItem(
      imageUrl: "assets/images/DA45.JPG",
      title: "DA45: 10\" 3 Compartment Square Tray",
      type: "Compartment",
      description: "This is a 10\" 3 compartment square tray.",
    ),
    ProductItem(
      imageUrl: "assets/images/DA55.JPG",
      title: "DA55: 5 Compartment Meal Tray XL",
      type: "Compartment",
      description: "This is a 5 compartment meal tray XL.",
    ),
    ProductItem(
      imageUrl: "assets/images/DA56.JPG",
      title: "DA56: 4 Compartment Meal Tray XL",
      type: "Compartment",
      description: "This is a 4 compartment meal tray XL.",
    ),
    ProductItem(
      imageUrl: "assets/images/DA05.jpg",
      title: "DA05: 6 Inch Round",
      type: "Round",
      description: "This is a 6-inch round tray.",
    ),
    ProductItem(
      imageUrl: "assets/images/DA06.jpg",
      title: "DA06: 7 Inch Round",
      type: "Round",
      description: "This is a 7-inch round tray.",
    ),
    ProductItem(
      imageUrl: "assets/images/DA11.jpg",
      title: "DA11: 9 Inch Round",
      type: "Round",
      description: "This is a 9-inch round tray.",
    ),
    ProductItem(
      imageUrl: "assets/images/DA52.jpg",
      title: "DA52: 9 Inch Deep Round",
      type: "Round",
      description: "This is a 9-inch deep round tray.",
    ),
    ProductItem(
      imageUrl: "assets/images/DA07.jpg",
      title: "DA07: 10 Inch Round",
      type: "Round",
      description: "This is a 10-inch round tray.",
    ),
    ProductItem(
      imageUrl: "assets/images/DA53.jpg",
      title: "DA53: 10 Inch Deep Round",
      type: "Round",
      description: "This is a 10-inch deep round tray.",
    ),
    ProductItem(
      imageUrl: "assets/images/DA27.jpg",
      title: "DA27: 11 Inch Round",
      type: "Round",
      description: "This is an 11-inch round tray.",
    ),
    ProductItem(
      imageUrl: "assets/images/DA12.jpg",
      title: "DA12: 12 Inch Round",
      type: "Round",
      description: "This is a 12-inch round tray.",
    ),
    ProductItem(
      imageUrl: "assets/images/DA16.jpg",
      title: "DA16: 12.5 Inch x 10 inch Oval",
      type: "Round",
      description: "This is a 12.5x10 inch oval tray.",
    ),
    ProductItem(
      imageUrl: "assets/images/DA54.jpg",
      title: "DA54: 4\" Square",
      type: "Square Rectangle",
      description: "This is a 4-inch square tray.",
    ),
    ProductItem(
      imageUrl: "assets/images/DA13.jpg",
      title: "DA13: 5.5\" Square",
      type: "Square Rectangle",
      description: "This is a 5.5-inch square tray.",
    ),
    ProductItem(
      imageUrl: "assets/images/DA50.jpg",
      title: "DA50: 7\" Square",
      type: "Square Rectangle",
      description: "This is a 7-inch square tray.",
    ),
    ProductItem(
      imageUrl: "assets/images/DA35.jpg",
      title: "DA35: 9\" Square",
      type: "Square Rectangle",
      description: "This is a 9-inch square tray.",
    ),
    ProductItem(
      imageUrl: "assets/images/DA46.jpg",
      title: "DA46: 7\" x 5\" Chips",
      type: "Square Rectangle",
      description: "This is a 7x5 inch chips tray.",
    ),
    ProductItem(
      imageUrl: "assets/images/DA14.jpg",
      title: "DA14: 8.5\" x 5.5\" Rectangular",
      type: "Square Rectangle",
      description: "This is an 8.5x5.5 inch rectangular tray.",
    ),
    ProductItem(
      imageUrl: "assets/images/DA51.jpg",
      title: "DA51: 2 Compartment Tray",
      type: "Square Rectangle",
      description: "This is a 2 compartment square tray.",
    ),
    ProductItem(
      imageUrl: "assets/images/DA22.jpg",
      title: "DA22: 100ml/ 4 oz (PET Lid Available)",
      type: "Multipurpose",
      description:
          "This is a 100ml/4 oz multipurpose container with PET lid available.",
    ),
    ProductItem(
      imageUrl: "assets/images/DA01.jpg",
      title: "DA01: 180 ml / 6 oz",
      type: "Multipurpose",
      description: "This is a 180ml/6 oz multipurpose container.",
    ),
    ProductItem(
      imageUrl: "assets/images/DA02.jpg",
      title: "DA02: 240 ml / 8 oz",
      type: "Multipurpose",
      description: "This is a 240ml/8 oz multipurpose container.",
    ),
    ProductItem(
      imageUrl: "assets/images/DA03.jpg",
      title: "DA03: 150 ml Square",
      type: "Multipurpose",
      description: "This is a 150ml square multipurpose container.",
    ),
    ProductItem(
      imageUrl: "assets/images/DA28.jpg",
      title: "DA28: 12 oz",
      type: "Multipurpose",
      description: "This is a 12 oz multipurpose container.",
    ),
    ProductItem(
      imageUrl: "assets/images/DA38.jpg",
      title: "DA38: 16 oz",
      type: "Multipurpose",
      description: "This is a 16 oz multipurpose container.",
    ),
    ProductItem(
      imageUrl: "assets/images/DA04.jpg",
      title: "DA04: 350 ml (Lid Available)",
      type: "Multipurpose",
      description:
          "This is a 350ml multipurpose container with a lid available.",
    ),
    ProductItem(
      imageUrl: "assets/images/DA23.jpg",
      title: "DA23: 500 ml (Lid Available)",
      type: "Multipurpose",
      description:
          "This is a 500ml multipurpose container with a lid available.",
    ),
    ProductItem(
      imageUrl: "assets/images/DA20.jpg",
      title: "DA20: 500 ml / 16 oz Rectangular (Lid Available)",
      type: "Multipurpose",
      description:
          "This is a 500ml/16 oz rectangular multipurpose container with a lid available.",
    ),
    ProductItem(
      imageUrl: "assets/images/DA29.jpg",
      title: "DA29: 8 inch x 8 inch",
      type: "Takeaway",
      description: "This is an 8x8 inch takeaway container.",
    ),
    ProductItem(
      imageUrl: "assets/images/DA47.jpg",
      title: "DA47: 8 inch x 8 inch 3 Compartment",
      type: "Takeaway",
      description: "This is an 8x8 inch 3 compartment takeaway container.",
    ),
    ProductItem(
      imageUrl: "assets/images/DA34.jpg",
      title: "DA34: 9 inch x 9 inch",
      type: "Takeaway",
      description: "This is a 9x9 inch takeaway container.",
    ),
    ProductItem(
      imageUrl: "assets/images/DA17.jpg",
      title: "DA17: 9 inch x 9 inch 3 Compartment",
      type: "Takeaway",
      description: "This is a 9x9 inch 3 compartment takeaway container.",
    ),
    ProductItem(
      imageUrl: "assets/images/DA43.jpg",
      title: "DA43: 7\" x 5\" Small bio",
      type: "Takeaway",
      description: "This is a 7x5 inch small bio takeaway container.",
    ),
    ProductItem(
      imageUrl: "assets/images/DA44.jpg",
      title: "DA44: 9\" x 6\" Medium bio",
      type: "Takeaway",
      description: "This is a 9x6 inch medium bio takeaway container.",
    ),
  ];

  @override
  void initState() {
    super.initState();
    selectedCost = [optionCost[0]];
    productItemsTemp = productItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Explore DineEarth Collection"),
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                left: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.centerLeft,
                    child: ChipsChoice<String>.single(
                      value: selectedCost.isNotEmpty ? selectedCost[0] : null,
                      onChanged: (val) {
                        if (val == "All") {
                          setState(() {
                            selectedCost = [val];
                          });

                          productItems = productItemsTemp;
                        } else {
                          productItems = productItemsTemp;

                          setState(() {
                            selectedCost = [val];
                          });

                          productItems = productItems
                              .where((item) => item.type == val)
                              .toList();
                        }
                        Fluttertoast.showToast(msg: "Applied $val filter");
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
                        source: optionCost,
                        value: (i, v) => v,
                        label: (i, v) => v,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 20.0),
                    child: Text(
                      "Showing ${selectedCost.isNotEmpty ? selectedCost[0] : "None"} DineEarth collection",
                      style: const TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 18,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: ListView.builder(
                itemCount: productItems.length,
                itemBuilder: (context, index) {
                  return CustomCard3(
                    assetUrl: productItems[index].imageUrl,
                    title: productItems[index].title,
                    type: productItems[index].type,
                    description: productItems[index].description,
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 18.0),
        child: FloatingActionButton(
          onPressed: () async {
            if (!await launchUrl(Uri.parse("tel:9168202971"))) {
              throw Exception('Could not launch');
            }
          },
          backgroundColor: Colors.green.shade50,
          child: const Icon(Icons.call),
        ),
      ),
    );
  }
}

class ProductItem {
  final String imageUrl;
  final String title;
  final String type;
  final String description;

  ProductItem({
    required this.imageUrl,
    required this.title,
    required this.type,
    required this.description,
  });
}
