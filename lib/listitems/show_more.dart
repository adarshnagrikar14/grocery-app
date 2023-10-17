// ignore_for_file: library_private_types_in_public_api, must_be_immutable

import 'package:chips_choice/chips_choice.dart';
import 'package:demoapp/cust_card.dart';
import 'package:demoapp/dashboard_pages/search.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowMorePage extends StatefulWidget {
  final String type;

  const ShowMorePage({super.key, required this.type});

  @override
  State<ShowMorePage> createState() => _ShowMorePageState();
}

class _ShowMorePageState extends State<ShowMorePage> {
  late String crockeryType;

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
    "Affordable",
    "Reasonable",
    "Premium",
  ];

  List<String> imageUrl = [
    "assets/images/cont1.jpg",
    "assets/images/cont3.jpg",
    "assets/images/cont2.jpg",
    "assets/images/cont4.jpg",
    "assets/images/raw1.jpg",
    "assets/images/raw2.jpg",
    "assets/images/raw3.jpg",
    "assets/images/raw4.jpg",
    "assets/images/tissue1.jpg",
    "assets/images/tissue2.jpg",
    "assets/images/tissue3.jpg",
    "assets/images/tissue4.jpg",
    "assets/images/cont4.jpg",
    "assets/images/cont2.jpg",
    "assets/images/cont1.jpg",
  ];

  @override
  void initState() {
    super.initState();
    selectedCost = [optionCost[0]];
    crockeryType = "";
  }

  @override
  Widget build(BuildContext context) {
    final String type = widget.type;

    setState(() {
      crockeryType = type;
    });

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.0,
        title: Text(
          "Fetaured Products for You",
          style: TextStyle(
            fontSize: 22.0,
            fontFamily: GoogleFonts.tiltNeon().fontFamily,
          ),
        ),
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Card(
              color: Colors.white,
              elevation: 1.0,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 10.0,
                  left: 20.0,
                  right: 20.0,
                  bottom: 10.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => _showSortOptions(),
                        child: const Row(
                          children: [
                            Icon(Icons.sort),
                            SizedBox(width: 18.0),
                            Text(
                              "Sort",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: _showFilterOptions,
                        child: Row(
                          children: [
                            Container(
                              color: Colors.grey,
                              width: 1.0,
                              height: 40.0,
                            ),
                            const SizedBox(width: 15.0),
                            const Icon(Icons.filter_list),
                            const SizedBox(width: 18.0),
                            const Text(
                              "Filter",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
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
                      "Showing all ${selectedCost.isNotEmpty ? selectedCost[0] : "None"} $crockeryType collection",
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
              padding: const EdgeInsets.only(bottom: 20.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.67,
                ),
                itemCount: imageUrl.length,
                itemBuilder: (context, index) {
                  return CustomCard2(
                    assetUrl: imageUrl[index],
                    title: "Product ${index + 1}: $crockeryType",
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 300.0,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Center(
                  child: Container(
                    width: 60.0,
                    height: 5.0,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 12.0,
                  left: 12.0,
                ),
                child: ListTile(
                  title: const Text("Sort By"),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.close,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: optionSort.length,
                  itemBuilder: (context, index) {
                    return RadioListTile(
                      title: Text(optionSort[index]),
                      value: index,
                      groupValue: selectedSort,
                      onChanged: (int? value) {
                        setState(() {
                          selectedSort = value!;
                          imageUrl.shuffle();
                        });
                        Navigator.pop(context);

                        Fluttertoast.showToast(
                            msg: "Applying ${optionSort[selectedSort]}");
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return CustomFilter(
          imageUrls: imageUrl,
          onFilterApplied: (filteredUrls) {
            setState(() {
              imageUrl = filteredUrls;
            });
          },
        );
      },
    );
  }
}

class CustomFilter extends StatefulWidget {
  final List<String> imageUrls;
  final Function(List<String>) onFilterApplied;

  const CustomFilter({
    required this.imageUrls,
    required this.onFilterApplied,
    Key? key,
  }) : super(key: key);

  @override
  _CustomFilterState createState() => _CustomFilterState();
}

class _CustomFilterState extends State<CustomFilter> {
  List<String> optionSize = [
    "Small",
    "Medium",
    "Large",
  ];

  List<String> optionsColor = [
    "White",
    "Black",
    "Multicolor",
  ];

  List<String> optionsStyle = [
    "Traditional",
    "Ethnic",
    "Cartoon",
    "Colorful",
  ];

  List<String> selectedSize = [];
  List<String> selectedColor = [];
  List<String> selectedStyle = [];

  @override
  void initState() {
    super.initState();
    selectedSize = [optionSize[0]];
    selectedColor = [optionsColor[0]];
    selectedStyle = [optionsStyle[0]];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(
                child: Container(
                  width: 60.0,
                  height: 5.0,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(
                // top: 12.0,
                left: 3.0,
              ),
              child: ListTile(
                title: const Text("Filter by"),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.close,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
          ),
          Expanded(
            flex: 11,
            child: SizedBox(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 19.0,
                    right: 18.0,
                    top: 20.0,
                    bottom: 20.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 1.0,
                        color: Colors.grey,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          "Size",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      ChipsChoice<String>.single(
                        value: selectedSize.isNotEmpty ? selectedSize[0] : null,
                        onChanged: (val) {
                          setState(() {
                            selectedSize = [val];
                          });
                        },
                        choiceStyle: C2ChipStyle.filled(
                          color: Colors.white,
                          checkmarkColor: Colors.green.shade900,
                          selectedStyle: C2ChipStyle.filled(
                            color: Colors.green.shade100,
                          ),
                        ),
                        choiceCheckmark: true,
                        choiceItems: C2Choice.listFrom<String, String>(
                          source: optionSize,
                          value: (i, v) => v,
                          label: (i, v) => v,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          "Color",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      ChipsChoice<String>.single(
                        value:
                            selectedColor.isNotEmpty ? selectedColor[0] : null,
                        onChanged: (val) {
                          setState(() {
                            selectedColor = [val];
                          });
                        },
                        choiceStyle: C2ChipStyle.filled(
                          color: Colors.white,
                          checkmarkColor: Colors.green.shade900,
                          selectedStyle: C2ChipStyle.filled(
                            color: Colors.green.shade100,
                          ),
                        ),
                        choiceCheckmark: true,
                        choiceItems: C2Choice.listFrom<String, String>(
                          source: optionsColor,
                          value: (i, v) => v,
                          label: (i, v) => v,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          "Style",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      ChipsChoice<String>.single(
                        value:
                            selectedStyle.isNotEmpty ? selectedStyle[0] : null,
                        onChanged: (val) {
                          setState(() {
                            selectedStyle = [val];
                          });
                        },
                        choiceStyle: C2ChipStyle.filled(
                          color: Colors.white,
                          checkmarkColor: Colors.green.shade900,
                          selectedStyle: C2ChipStyle.filled(
                            color: Colors.green.shade100,
                          ),
                        ),
                        choiceCheckmark: true,
                        choiceItems: C2Choice.listFrom<String, String>(
                          source: optionsStyle,
                          value: (i, v) => v,
                          label: (i, v) => v,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                bottom: 10.0,
                left: 15.0,
                right: 15.0,
              ),
              child: SizedBox(
                height: 50.0,
                width: MediaQuery.of(context).size.width,
                child: OutlinedButton(
                  onPressed: () {
                    applyFilter();
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.green.shade800),
                    backgroundColor: Colors.green.shade300,
                  ),
                  child: const Text(
                    "Apply Filters",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void applyFilter() {
    List<String> filteredImageUrls = widget.imageUrls;
    filteredImageUrls.shuffle();
    widget.onFilterApplied(filteredImageUrls);

    Fluttertoast.showToast(msg: "Applying Filter");
    Navigator.pop(context);
  }
}
