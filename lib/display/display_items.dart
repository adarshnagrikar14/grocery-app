// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class DisplayItemPage extends StatefulWidget {
  final String imageUrl;
  final String productName;
  final String desc;

  const DisplayItemPage({
    super.key,
    required this.imageUrl,
    required this.productName,
    required this.desc,
  });

  @override
  State<DisplayItemPage> createState() => _DisplayItemPageState();
}

class _DisplayItemPageState extends State<DisplayItemPage> {
  String imageUrl = "";
  String prodName = "";
  String prodDescription = "";

  @override
  void initState() {
    super.initState();

    imageUrl = widget.imageUrl;
    prodName = widget.productName;
    prodDescription = widget.desc;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(prodName),
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
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.network(
                      imageUrl,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 23.0,
                      left: 3,
                    ),
                    child: Text(
                      prodName,
                      style: const TextStyle(
                        fontSize: 22.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 8.0,
                      left: 3,
                    ),
                    child: Text(
                      prodDescription,
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 4,
                      softWrap: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                      bottom: 10.0,
                    ),
                    child: RatingBar.builder(
                      initialRating: 4.2,
                      minRating: 0.5,
                      maxRating: 5,
                      direction: Axis.horizontal,
                      unratedColor: Colors.green,
                      allowHalfRating: true,
                      itemCount: 5,
                      ignoreGestures: true,
                      itemSize: 17.0,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {},
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 1.2,
                    color: Colors.grey,
                  ),
                  RoundedBorderButton(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return SizeFilter(
                            onFilterApplied: (sizeSelected) {},
                          );
                        },
                      );
                    },
                    text: "Add to Wishlist",
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 15.0,
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 1.2,
                      color: Colors.grey,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 10.0,
                      left: 3,
                    ),
                    child: Text(
                      "Features of the product",
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 18.0,
                      bottom: 20.0,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Chip(
                            label: const Text("Feature 1"),
                            avatar: const Icon(
                              Icons.check,
                              color: Colors.green,
                            ),
                            backgroundColor: Colors.green.shade100,
                            labelStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 8.0,
                              right: 8.0,
                            ),
                            child: Chip(
                              label: const Text("Feature 2"),
                              avatar: const Icon(
                                Icons.check,
                                color: Colors.green,
                              ),
                              backgroundColor: Colors.green.shade100,
                              labelStyle: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Chip(
                            label: const Text("Feature 3"),
                            avatar: const Icon(
                              Icons.check,
                              color: Colors.green,
                            ),
                            backgroundColor: Colors.green.shade100,
                            labelStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 5.0,
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 1.2,
                      color: Colors.grey,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 10.0,
                      left: 3,
                      bottom: 50.0,
                    ),
                    child: Text(
                      "More such products",
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 50.0,
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
                  child: const Icon(
                    Icons.call,
                    size: 30.0,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                FloatingActionButton(
                  onPressed: () async {
                    if (!await launchUrl(
                        Uri.parse("https://wa.me/919168202971"))) {
                      throw Exception('Could not launch');
                    }
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
}

class SizeFilter extends StatefulWidget {
  final Function(String) onFilterApplied;

  const SizeFilter({
    required this.onFilterApplied,
    Key? key,
  }) : super(key: key);

  @override
  _SizeFilterState createState() => _SizeFilterState();
}

class _SizeFilterState extends State<SizeFilter> {
  List<String> selectedSize = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250.0,
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
                title: const Text("Add To Wishlist?"),
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
            flex: 3,
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
                          "You Can see items added in wishlist in the menu option given below.",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                            color: Colors.black,
                          ),
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
                    Fluttertoast.showToast(msg: "Added to Wishlist");
                    applyFilter();
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.green.shade800),
                    backgroundColor: Colors.green.shade300,
                  ),
                  child: const Text(
                    "Add to Wishlist",
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
    Navigator.pop(context);
    widget.onFilterApplied(selectedSize[0]);
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
      ),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          side: BorderSide(
            color: Colors.yellow.shade900,
            width: MediaQuery.of(context).size.width * 0.002,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          backgroundColor: Colors.yellow.shade300,
          minimumSize: Size(
            MediaQuery.of(context).size.width,
            50.0,
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 17.0,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

class RoundedBorderButtonGreen extends StatelessWidget {
  final VoidCallback onTap;
  final String text;

  const RoundedBorderButtonGreen({
    Key? key,
    required this.onTap,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 28.0,
      ),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          side: BorderSide(
            color: Colors.green.shade900,
            width: MediaQuery.of(context).size.width * 0.002,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          backgroundColor: Colors.green.shade100,
          minimumSize: Size(
            MediaQuery.of(context).size.width,
            50.0,
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 17.0,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
