// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api, avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:chips_choice/chips_choice.dart';
import 'package:demoapp/wishlist/wishlist_af.dart';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_share/whatsapp_share.dart';
import 'package:http/http.dart' as http;

class DisplayItemPage extends StatefulWidget {
  final String productID;

  const DisplayItemPage({
    super.key,
    required this.productID,
  });

  @override
  State<DisplayItemPage> createState() => _DisplayItemPageState();
}

class _DisplayItemPageState extends State<DisplayItemPage> {
  late String imageUrl;
  late String prodName;
  String prodDescription = "";

  late bool _visible;

  List<String> desc = [
    "Our Plate Cardboard is more than just a serving solution; it's your sustainable partner. Crafted from durable materials, it's designed to withstand the weight of your favorite dishes while being environmentally conscious. Choose it for a guilt-free dining experience that's both robust and eco-friendly.",
    "Our Tissue General offers the perfect blend of resilience and responsibility. With excellent absorbency and strength, it tackles spills and messes effectively. Plus, it's an eco-friendly choice, crafted from sustainable materials to help maintain hygiene while preserving the planet.",
    "Our Container is not just for storing your meals; it's designed to last. Its sturdy construction ensures that your food remains fresh, safe, and secure. What's more, it's an eco-conscious choice, made from sustainable materials, so you can savor your meals knowing you're making a responsible choice for the environment",
    "Our Toothpicks are more than just handy tools; they're crafted to withstand the rigors of daily use. Their sturdiness makes them perfect for a variety of tasks. In addition to durability, they are made from sustainable materials, combining strength with eco-friendliness to meet your needs while caring for the planet.",
  ];

  final random = Random();
  int randomIndex = 0;

  int quantity = 2;

  void incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    imageUrl = "";
    prodName = "";
    _visible = false;

    randomIndex = random.nextInt(desc.length);
    prodDescription = desc[randomIndex];

    fetchProductData(widget.productID);
  }

  Future<void> fetchProductData(String productID) async {
    final url = Uri.parse(
      'https://assignme-work.000webhostapp.com/venus/depthfetch.php?ProductID=$productID',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        imageUrl = data['ImageLink'];
        prodName = data['ProductName'];
        prodDescription = data['ProductDescription'];
      });
    } else {
      Fluttertoast.showToast(msg: "Failed to fetch product data.");
    }

    setState(() {
      _visible = true;
    });
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
          Visibility(
            visible: _visible,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.asset(
                            imageUrl,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                            height: MediaQuery.of(context).size.width,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 10.0,
                            top: 10.0,
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) {
                                    return Scaffold(
                                      appBar: AppBar(
                                        title: Text(
                                          prodName,
                                        ),
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
                                      body: PhotoView(
                                        imageProvider: AssetImage(
                                          imageUrl,
                                        ),
                                        minScale:
                                            PhotoViewComputedScale.contained,
                                        backgroundDecoration:
                                            const BoxDecoration(
                                          color: Colors.white,
                                        ),
                                        maxScale:
                                            PhotoViewComputedScale.covered * 2,
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                            child: Align(
                              alignment: Alignment.topRight,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Container(
                                  color: Colors.white,
                                  child: const Icon(
                                    Icons.zoom_out_map,
                                    size: 32.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 20.0,
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: 1.2,
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10.0,
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
                        desc[randomIndex],
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w300,
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
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 18.0,
                        left: 3,
                      ),
                      child: Text(
                        "Add to your Wishlist",
                        style: TextStyle(
                          fontSize: 17.0,
                          color: Colors.black87.withAlpha(180),
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 4,
                        softWrap: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 5.0,
                        left: 3,
                        bottom: 5.0,
                      ),
                      child: Text(
                        "Product by Venus (India) Incorporation.",
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.black87.withAlpha(130),
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 4,
                        softWrap: true,
                      ),
                    ),
                    RoundedBorderButton(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return SizeFilter(
                              onFilterApplied: (sizeSelected) {
                                addToWishlist(
                                  sizeSelected,
                                  desc[randomIndex],
                                  widget.productID,
                                );
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
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 18.0,
                        left: 3,
                      ),
                      child: Text(
                        "Whatsapp Us",
                        style: TextStyle(
                          fontSize: 17.0,
                          color: Colors.black87.withAlpha(180),
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 4,
                        softWrap: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8.0,
                        left: 3,
                        bottom: 10.0,
                      ),
                      child: Text(
                        "Select the Quantity and hit Whatsapp Share to Send your Choice Directly to Us.",
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.black87.withAlpha(130),
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 4,
                        softWrap: true,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            children: <Widget>[
                              IconButton(
                                onPressed: decrementQuantity,
                                icon: const Icon(Icons.remove),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 5.0,
                                  vertical: 2.50,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                                child: Text(
                                  '$quantity',
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ),
                              IconButton(
                                onPressed: incrementQuantity,
                                icon: const Icon(Icons.add),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: RoundedBorderButtonGreen(
                            onTap: () {
                              _shareOnWhatsApp();
                            },
                            text: "Whatsapp Share",
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 25.0,
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
          ),
          Visibility(
            visible: _visible,
            child: Positioned(
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
          ),
          Visibility(
            visible: !_visible,
            child: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    LottieBuilder.asset(
                      'assets/raw/loading.json',
                      height: 100,
                      reverse: true,
                      repeat: true,
                    ),
                    const Text(
                      "Loading...",
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _shareOnWhatsApp() async {
    final ByteData byteData = await rootBundle.load(imageUrl);
    final Directory? directory1 = await getExternalStorageDirectory();

    final List<int> imageData = byteData.buffer.asUint8List();

    String textToConvt = "$prodName. Quantity: ${quantity.toString()}";
    final textImage = await textToImage(textToConvt);

    if (directory1 != null) {
      final File file2 = File('${directory1.path}/shareable_text.jpg');
      final File file1 = File('${directory1.path}/shareable.jpg');

      try {
        await file1.writeAsBytes(imageData);
        await file2.writeAsBytes(textImage);

        await WhatsappShare.shareFile(
          phone: '919168202971',
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

  void addToWishlist(String prodSize, String prodDesc, String productID) async {
    _showCustomProgressDialog(context);

    String result = await saveItemToDB(
      imageUrl,
      prodName,
      prodSize,
      prodDesc,
      productID,
    );

    // dis dialog
    Navigator.of(context).pop();

    if (result == "Success") {
      Fluttertoast.showToast(msg: "Item Added to wishlist");
    } else {
      Fluttertoast.showToast(msg: "Retry Adding Item.");
    }
  }

  void _showCustomProgressDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: Colors.green,
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Text("Adding to wishlist..."),
                ],
              ),
            ),
          ),
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
        top: 18.0,
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
        top: 12.0,
        left: 10,
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
            55.0,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              padding: const EdgeInsets.all(
                12.0,
              ),
              child: Image.asset(
                'assets/images/what.png',
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 17.0,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
