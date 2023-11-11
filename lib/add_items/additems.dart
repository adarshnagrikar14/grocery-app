// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:chips_choice/chips_choice.dart';
import 'package:demoapp/dashboard_pages/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class AddItems extends StatefulWidget {
  const AddItems({super.key});

  @override
  State<AddItems> createState() => _AddItemsState();
}

class _AddItemsState extends State<AddItems> {
  TextEditingController productNameTC = TextEditingController();
  TextEditingController productDescriptionTC = TextEditingController();
  TextEditingController productFeatureTC = TextEditingController();

  List<String> selectedProductType = [];
  final List<String> optionProductType = [
    "Plate",
    "Container",
    "Tissuess",
    "Toothpick",
    "Cuttlery",
    "Others",
  ];

  List<String> selectedManufacturerType = [];
  final List<String> optionManufacturerType = [
    "Venus Inc. (India)",
    "Dinearth",
  ];

  List<String> selectedSizeType = [];
  final List<String> optionSizeType = [
    "Small",
    "Medium",
    "Large",
  ];

  List<String> selectedColorType = [];
  final List<String> optionColorType = [
    "White",
    "Black",
    "Multicolor",
  ];

  List<String> selectedStyleType = [];
  final List<String> optionStyleType = [
    "Traditional",
    "Ethnic",
    "Cartoon",
    "Colorful",
  ];

  List<String> selectedPricingType = [];
  final List<String> optionPricingType = [
    "Affordable",
    "Reasonable",
    "Premium",
  ];

  // image select random
  List<String> rImage = [
    "assets/images/raw1.jpg",
    "assets/images/raw2.jpg",
    "assets/images/cont1.jpg",
    "assets/images/cont2.jpg",
    "assets/images/tissue1.jpg",
    "assets/images/tissue2.jpg",
    "assets/images/cont3.jpg",
    "assets/images/raw3.jpg",
    "assets/images/tissue4.jpg",
  ];

  final random = Random();
  int randomIndex = 0;

  String productImageLink = "";

  @override
  void initState() {
    super.initState();
    randomIndex = random.nextInt(rImage.length);
    productImageLink = rImage[randomIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Items"),
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
                top: 25.0,
                left: 20.0,
              ),
              child: Text(
                "Product Name",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0,
                  fontFamily: GoogleFonts.tiltNeon().fontFamily,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 18.0,
                left: 18.0,
                right: 18.0,
              ),
              child: TextField(
                controller: productNameTC,
                decoration: InputDecoration(
                  labelText: "Enter Product Name",
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.green,
                      width: 1.2,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            const Space(top: 20, bottom: 1),
            Padding(
              padding: const EdgeInsets.only(
                top: 25.0,
                left: 20.0,
              ),
              child: Text(
                "Product Description",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0,
                  fontFamily: GoogleFonts.tiltNeon().fontFamily,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 18.0,
                left: 18.0,
                right: 18.0,
              ),
              child: TextField(
                controller: productDescriptionTC,
                maxLines: null,
                minLines: 3,
                decoration: InputDecoration(
                  labelText: "Enter Product Description",
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.green,
                      width: 1.2,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            const Space(top: 20, bottom: 1),
            Padding(
              padding: const EdgeInsets.only(
                top: 25.0,
                left: 20.0,
              ),
              child: Text(
                "Product Features",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0,
                  fontFamily: GoogleFonts.tiltNeon().fontFamily,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 12.0,
                left: 20.0,
                right: 20.0,
                bottom: 10.0,
              ),
              child: Text(
                "Enter features Seperated with Comma.",
                style: TextStyle(
                  fontSize: 15.0,
                  fontFamily: GoogleFonts.tiltNeon().fontFamily,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 18.0,
                left: 18.0,
                right: 18.0,
              ),
              child: TextField(
                controller: productFeatureTC,
                decoration: InputDecoration(
                  labelText: "Enter Product Features",
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.green,
                      width: 1.2,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            const Space(top: 20, bottom: 1),
            Padding(
              padding: const EdgeInsets.only(
                top: 25.0,
                left: 20.0,
              ),
              child: Text(
                "Product Type",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0,
                  fontFamily: GoogleFonts.tiltNeon().fontFamily,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 12.0,
                left: 20.0,
                right: 20.0,
              ),
              child: Text(
                "Select the One that Applies.",
                style: TextStyle(
                  fontSize: 15.0,
                  fontFamily: GoogleFonts.tiltNeon().fontFamily,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                top: 12.0,
                left: 5.0,
                right: 18.0,
              ),
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              child: ChipsChoice<String>.single(
                value: selectedProductType.isNotEmpty
                    ? selectedProductType[0]
                    : null,
                onChanged: (val) {
                  setState(() {
                    selectedProductType = [val];
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
                wrapped: true,
                spacing: 20.0,
                alignment: WrapAlignment.spaceBetween,
                choiceItems: C2Choice.listFrom<String, String>(
                  source: optionProductType,
                  value: (i, v) => v,
                  label: (i, v) => v,
                ),
              ),
            ),
            const Space(top: 20, bottom: 1),
            Padding(
              padding: const EdgeInsets.only(
                top: 25.0,
                left: 20.0,
              ),
              child: Text(
                "Manufacturer",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0,
                  fontFamily: GoogleFonts.tiltNeon().fontFamily,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 12.0,
                left: 20.0,
                right: 20.0,
              ),
              child: Text(
                "Select the One that Applies.",
                style: TextStyle(
                  fontSize: 15.0,
                  fontFamily: GoogleFonts.tiltNeon().fontFamily,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                top: 12.0,
                left: 5.0,
                right: 18.0,
              ),
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              child: ChipsChoice<String>.single(
                value: selectedManufacturerType.isNotEmpty
                    ? selectedManufacturerType[0]
                    : null,
                onChanged: (val) {
                  setState(() {
                    selectedManufacturerType = [val];
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
                wrapped: true,
                spacing: 20.0,
                alignment: WrapAlignment.spaceBetween,
                choiceItems: C2Choice.listFrom<String, String>(
                  source: optionManufacturerType,
                  value: (i, v) => v,
                  label: (i, v) => v,
                ),
              ),
            ),
            const Space(top: 20, bottom: 1),
            Padding(
              padding: const EdgeInsets.only(
                top: 25.0,
                left: 20.0,
              ),
              child: Text(
                "Manufacturer",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0,
                  fontFamily: GoogleFonts.tiltNeon().fontFamily,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 12.0,
                left: 20.0,
                right: 20.0,
              ),
              child: Text(
                "Select the One that Applies.",
                style: TextStyle(
                  fontSize: 15.0,
                  fontFamily: GoogleFonts.tiltNeon().fontFamily,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                top: 12.0,
                left: 5.0,
                right: 18.0,
              ),
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              child: ChipsChoice<String>.single(
                value: selectedManufacturerType.isNotEmpty
                    ? selectedManufacturerType[0]
                    : null,
                onChanged: (val) {
                  setState(() {
                    selectedManufacturerType = [val];
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
                wrapped: true,
                spacing: 20.0,
                alignment: WrapAlignment.spaceBetween,
                choiceItems: C2Choice.listFrom<String, String>(
                  source: optionManufacturerType,
                  value: (i, v) => v,
                  label: (i, v) => v,
                ),
              ),
            ),
            const Space(top: 20, bottom: 1),
            Padding(
              padding: const EdgeInsets.only(
                top: 25.0,
                left: 20.0,
              ),
              child: Text(
                "Filters",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0,
                  fontFamily: GoogleFonts.tiltNeon().fontFamily,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 12.0,
                left: 20.0,
                right: 20.0,
              ),
              child: Text(
                "Select All Applicable Filters (More Than One).",
                style: TextStyle(
                  fontSize: 15.0,
                  fontFamily: GoogleFonts.tiltNeon().fontFamily,
                ),
              ),
            ),
            // sizes
            Container(
              padding: const EdgeInsets.only(
                top: 12.0,
                left: 5.0,
                right: 18.0,
              ),
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              child: ChipsChoice<String>.multiple(
                value: selectedSizeType,
                onChanged: (val) {
                  setState(() {
                    selectedSizeType = val;
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
                wrapped: true,
                spacing: 20.0,
                alignment: WrapAlignment.spaceBetween,
                choiceItems: C2Choice.listFrom<String, String>(
                  source: optionSizeType,
                  value: (i, v) => v,
                  label: (i, v) => v,
                ),
              ),
            ),
            const Space(top: 10, bottom: 1),

            //Colors
            Container(
              padding: const EdgeInsets.only(
                top: 12.0,
                left: 5.0,
                right: 18.0,
              ),
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              child: ChipsChoice<String>.multiple(
                value: selectedColorType,
                onChanged: (val) {
                  setState(() {
                    selectedColorType = val;
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
                wrapped: true,
                spacing: 20.0,
                alignment: WrapAlignment.spaceBetween,
                choiceItems: C2Choice.listFrom<String, String>(
                  source: optionColorType,
                  value: (i, v) => v,
                  label: (i, v) => v,
                ),
              ),
            ),
            const Space(top: 10, bottom: 1),

            //Style
            Container(
              padding: const EdgeInsets.only(
                top: 12.0,
                left: 5.0,
                right: 18.0,
              ),
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              child: ChipsChoice<String>.multiple(
                value: selectedStyleType,
                onChanged: (val) {
                  setState(() {
                    selectedStyleType = val;
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
                wrapped: true,
                spacing: 20.0,
                alignment: WrapAlignment.spaceBetween,
                choiceItems: C2Choice.listFrom<String, String>(
                  source: optionStyleType,
                  value: (i, v) => v,
                  label: (i, v) => v,
                ),
              ),
            ),
            const Space(top: 10, bottom: 1),

            //Pricing (aff, reasonable, premium)
            Container(
              padding: const EdgeInsets.only(
                top: 12.0,
                left: 5.0,
                right: 18.0,
              ),
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              child: ChipsChoice<String>.multiple(
                value: selectedPricingType,
                onChanged: (val) {
                  setState(() {
                    selectedPricingType = val;
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
                wrapped: true,
                spacing: 20.0,
                alignment: WrapAlignment.spaceBetween,
                choiceItems: C2Choice.listFrom<String, String>(
                  source: optionPricingType,
                  value: (i, v) => v,
                  label: (i, v) => v,
                ),
              ),
            ),
            const Space(top: 10, bottom: 1),

            Padding(
              padding: const EdgeInsets.only(
                top: 28.0,
                left: 10,
                right: 10.0,
              ),
              child: RoundedBorderButton(
                onTap: () => insertData(),
                text: "Upload Item",
              ),
            ),

            const SizedBox(
              height: 100.0,
            )
          ],
        ),
      ),
    );
  }

  Future<void> insertData() async {
    const String url =
        "https://assignme-work.000webhostapp.com/venus/additemallitem.php";

    final Map<String, dynamic> data = {
      'productName': productNameTC.text,
      'productType': selectedProductType[0],
      'manufacturer': selectedManufacturerType[0],
      'imageLink': productImageLink,
      'productDescription': productDescriptionTC.text,
      'filters': combineLists(
        selectedSizeType,
        selectedColorType,
        selectedStyleType,
        selectedPricingType,
      ),
      'feature': productFeatureTC.text,
    };

    final http.Response response = await http.post(
      Uri.parse(url),
      body: data,
    );

    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: "Done");
    } else {}
  }

  String combineLists(List<String> list1, List<String> list2,
      List<String> list3, List<String> list4) {
    List<String> combinedList = [];

    combinedList.addAll(list1);
    combinedList.addAll(list2);
    combinedList.addAll(list3);
    combinedList.addAll(list4);

    String result = combinedList.join(', ');

    return result;
  }
}
