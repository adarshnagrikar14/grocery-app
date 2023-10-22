// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api, avoid_print

import 'dart:async';
import 'dart:io';

import 'package:chips_choice/chips_choice.dart';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_share/whatsapp_share.dart';

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
                      // addToWishlist();
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return SizeFilter(
                            onFilterApplied: (sizeSelected) {
                              addToWishlist(sizeSelected);
                            },
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
                      bottom: 20.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Chip(
                            label: const Text("Feature 4"),
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Chip(
                              label: const Text("Feature 5"),
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
                            label: const Text("Feature 6"),
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
                  onPressed: () {
                    _shareOnWhatsApp();
                  },
                  backgroundColor: Colors.green.shade50,
                  child: Image.asset(
                    "assets/images/what.png",
                    width: 30.0,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                FloatingActionButton(
                  onPressed: () {
                    _launchCall();
                  },
                  backgroundColor: Colors.green.shade50,
                  child: const Icon(Icons.call),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchCall() async {
    if (!await launchUrl(Uri.parse("tel:9168202971"))) {
      throw Exception('Could not launch');
    }
  }

  Future<void> _shareOnWhatsApp() async {
    final ByteData byteData = await rootBundle.load(widget.imageUrl);
    final Directory? directory1 = await getExternalStorageDirectory();

    final List<int> imageData = byteData.buffer.asUint8List();
    final textImage = await textToImage(widget.productName);

    if (directory1 != null) {
      final File file2 = File('${directory1.path}/shareable_text.jpg');
      final File file1 = File('${directory1.path}/shareable.jpg');

      try {
        await file1.writeAsBytes(imageData);
        await file2.writeAsBytes(textImage);

        await WhatsappShare.shareFile(
          phone: '917620216605',
          filePath: [
            file1.path,
            file2.path,
          ],
        );
      } catch (e) {
        print('Error: $e');
      }
    } else {
      print("Ext storage dir. is null");
    }
  }

  Future<Uint8List> textToImage(String text) async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(
      recorder,
      Rect.fromPoints(
        const Offset(0, 0),
        const Offset(400, 100),
      ),
    );

    final textPainter = TextPainter(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: text,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 20.0,
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(minWidth: 400, maxWidth: 400);

    canvas.drawColor(
      Colors.white,
      BlendMode.color,
    );

    final offsetX = (400 - textPainter.width) / 2;
    final offsetY = (100 - textPainter.height) / 2;
    final textOffset = Offset(offsetX, offsetY);

    textPainter.paint(
      canvas,
      textOffset,
    );

    final picture = recorder.endRecording();
    final img = await picture.toImage(400, 100);
    final imgByteData = await img.toByteData(format: ui.ImageByteFormat.png);

    return imgByteData!.buffer.asUint8List();
  }

  void addToWishlist(String string) async {
    await saveToSharedPreferences(imageUrl, prodName, string);

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

  Future<void> saveToSharedPreferences(
      String imageUrl, String title, String string) async {
    setState(() {
      isAddingToWishlist = true;
    });

    final prefs = await SharedPreferences.getInstance();
    List<String> wishlist = prefs.getStringList('Wishlist3') ?? [];
    wishlist.add('$imageUrl;$title;$string');
    await prefs.setStringList('Wishlist3', wishlist);

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
  List<String> optionSize = [
    "Small",
    "Medium",
    "Large",
  ];

  List<String> selectedSize = [];

  @override
  void initState() {
    super.initState();
    selectedSize = [optionSize[0]];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300.0,
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
                title: const Text("Add required Size"),
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
            flex: 4,
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
    widget.onFilterApplied(selectedSize[0]);
    Navigator.pop(context);
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
