// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DisplayItemPage extends StatefulWidget {
  final String imageUrl;
  final String productName;

  const DisplayItemPage(
      {super.key, required this.imageUrl, required this.productName});

  @override
  State<DisplayItemPage> createState() => _DisplayItemPageState();
}

class _DisplayItemPageState extends State<DisplayItemPage> {
  String imageUrl = "";
  String prodName = "";

  List<String> selectedItems = [];

  List<String> options = [
    "Affordable",
    "Multicolor",
    "Small Size",
    "Easy to use",
  ];

  bool isAddingToWishlist = false;

  @override
  void initState() {
    super.initState();
    imageUrl = widget.imageUrl;
    prodName = widget.productName;

    selectedItems = [options[0]];
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.asset(
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
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.",
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
                  addToWishlist();
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
                  "Fetures of the product",
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
                        label: const Text("Fetaure 1"),
                        avatar: const Icon(
                          Icons.check,
                          color: Colors.green,
                        ),
                        backgroundColor: Colors.green.shade100,
                        labelStyle: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 8.0,
                          right: 8.0,
                        ),
                        child: Chip(
                          label: const Text("Fetaure 2"),
                          avatar: const Icon(
                            Icons.check,
                            color: Colors.green,
                          ),
                          backgroundColor: Colors.green.shade100,
                          labelStyle: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Chip(
                        label: const Text("Fetaure 3"),
                        avatar: const Icon(
                          Icons.check,
                          color: Colors.green,
                        ),
                        backgroundColor: Colors.green.shade100,
                        labelStyle: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 20.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Chip(
                        label: const Text("Fetaure 4"),
                        avatar: const Icon(
                          Icons.check,
                          color: Colors.green,
                        ),
                        backgroundColor: Colors.green.shade100,
                        labelStyle: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Chip(
                          label: const Text("Fetaure 5"),
                          avatar: const Icon(
                            Icons.check,
                            color: Colors.green,
                          ),
                          backgroundColor: Colors.green.shade100,
                          labelStyle: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Chip(
                        label: const Text("Fetaure 6"),
                        avatar: const Icon(
                          Icons.check,
                          color: Colors.green,
                        ),
                        backgroundColor: Colors.green.shade100,
                        labelStyle: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
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
    );
  }

  void addToWishlist() async {
    await saveToSharedPreferences(imageUrl, prodName);

    showDialog(
      context: context,
      builder: (context) {
        return const Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: 50.0,
            height: 50.0,
            child: CircularProgressIndicator(
              color: Colors.green,
            ),
          ),
        );
      },
    );
  }

  Future<void> saveToSharedPreferences(String imageUrl, String title) async {
    setState(() {
      isAddingToWishlist = true;
    });

    final prefs = await SharedPreferences.getInstance();
    List<String> wishlist = prefs.getStringList('Wishlist') ?? [];
    wishlist.add('$imageUrl;$title');
    await prefs.setStringList('Wishlist', wishlist);

    // dismiss indicartor
    Timer(
      const Duration(
        milliseconds: 1500,
      ),
      () {
        setState(() {
          isAddingToWishlist = false;
        });
        Navigator.of(context).pop();
        Fluttertoast.showToast(msg: "Item Added to wishlist");

        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return SizedBox(
              height: 250.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 12.0,
                      left: 12.0,
                    ),
                    child: ListTile(
                      title: Text(
                        "Item Added to Wishlist",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 25.0,
                      right: 25.0,
                    ),
                    child: Text(
                      "You can watch it in wishlist section",
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black45,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 20.0,
                      left: 25.0,
                      right: 25.0,
                    ),
                    child: RoundedBorderButton(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      text: "Done",
                    ),
                  ),
                ],
              ),
            );
          },
        );
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
