import 'package:chips_choice/chips_choice.dart';
import 'package:demoapp/cust_card_linear.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
    "Straws",
  ];

  List<String> imageUrl = [
    "assets/images/da08.jpg",
    "assets/images/da09.jpg",
    "assets/images/DA15.JPG",
    "assets/images/DA18.JPG",
    "assets/images/DA19.JPG",
    "assets/images/DA39.JPG",
    "assets/images/DA40.JPG",
    "assets/images/DA41.JPG",
    "assets/images/DA42.JPG",
    "assets/images/DA45.JPG",
    "assets/images/DA55.JPG",
    "assets/images/DA56.JPG",
  ];

  List<String> prodNames = [
    "DA08: 10\" 3 Compartment Round Tray",
    "DA09: 11\" 4 Compartment Round Tray",
    "DA15: 5 Compartment School Tray",
    "DA18: 12\" 4 Compartment Round Tray",
    "DA19: 9\" 3 Compartment Round Tray",
    "DA39: 6 Compartment Export Meal Tray",
    "DA40: 7 Compartment Round Tray",
    "DA41: 9 Compartment Round Tray",
    "DA42: 6 Compartment Meal Tray",
    "DA45: 10\" 3 Compartment Square Tray",
    "DA55: 5 Compartment Meal Tray XL",
    "DA56: 4 Compartment Meal Tray XL",
  ];

  @override
  void initState() {
    super.initState();
    selectedCost = [optionCost[1]];
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
                        setState(() {
                          selectedCost = [val];
                          imageUrl.shuffle();
                          prodNames.shuffle();
                        });

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
                itemCount: imageUrl.length,
                itemBuilder: (context, index) {
                  return CustomCard3(
                    assetUrl: imageUrl[index],
                    title: prodNames[index],
                    type: 'DineEarth Items',
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
