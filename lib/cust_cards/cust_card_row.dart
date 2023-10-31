// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:demoapp/display/display_item_af.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp_share/whatsapp_share.dart';

import 'dart:ui' as ui;

class CustomCardRow extends StatefulWidget {
  final String assetUrl;
  final String title;

  const CustomCardRow({
    required this.assetUrl,
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomCardRow> createState() => _CustomCardRowState();
}

class _CustomCardRowState extends State<CustomCardRow> {
  List<String> desc = [
    "Our Plate Cardboard is more than just a serving solution; it's your sustainable partner. Crafted from durable materials, it's designed to withstand the weight of your favorite dishes while being environmentally conscious. Choose it for a guilt-free dining experience that's both robust and eco-friendly.",
    "Our Tissue General offers the perfect blend of resilience and responsibility. With excellent absorbency and strength, it tackles spills and messes effectively. Plus, it's an eco-friendly choice, crafted from sustainable materials to help maintain hygiene while preserving the planet.",
    "Our Container is not just for storing your meals; it's designed to last. Its sturdy construction ensures that your food remains fresh, safe, and secure. What's more, it's an eco-conscious choice, made from sustainable materials, so you can savor your meals knowing you're making a responsible choice for the environment",
    "Our Toothpicks are more than just handy tools; they're crafted to withstand the rigors of daily use. Their sturdiness makes them perfect for a variety of tasks. In addition to durability, they are made from sustainable materials, combining strength with eco-friendliness to meet your needs while caring for the planet.",
  ];

  final random = Random();
  int randomIndex = 0;

  @override
  void initState() {
    super.initState();
    randomIndex = random.nextInt(desc.length);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.65,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DisplayItemPage(
                imageUrl: widget.assetUrl,
                productName: widget.title,
              ),
            ),
          );
        },
        child: Card(
          color: Colors.grey.shade50,
          elevation: 1.2,
          margin: const EdgeInsets.only(
            left: 10.0,
            right: 10.0,
            top: 15.0,
            bottom: 15.0,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.asset(
                        widget.assetUrl,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                        height: 160.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        desc[randomIndex],
                        style: const TextStyle(
                          fontSize: 13.0,
                          color: Colors.black87,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _shareOnWhatsApp();
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Share it"),
                            SizedBox(
                              width: 20.0,
                            ),
                            Icon(
                              Icons.send_rounded,
                              size: 20.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                //wishlist
                Padding(
                  padding: const EdgeInsets.only(
                    right: 5.0,
                    top: 5.0,
                  ),
                  child: InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return SizeFilter(
                            onFilterApplied: (sizeSelected) {
                              addToWishlist(sizeSelected, context);
                            },
                          );
                        },
                      );
                    },
                    child: Align(
                      alignment: Alignment.topRight,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Container(
                          color: Colors.white,
                          child: const Icon(
                            Icons.favorite_border,
                            size: 30.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addToWishlist(String string, BuildContext context) async {
    await saveToSharedPreferences(
        widget.assetUrl, widget.title, string, context);

    // Timer(
    //     const Duration(
    //       milliseconds: 1500,
    //     ),
    //     () {

    //     });

    // showDialog(
    //   context: context,
    //   builder: (context) {
    //     return const Align(
    //       alignment: Alignment.center,
    //       child: SizedBox(
    //         width: 50.0,
    //         height: 50.0,
    //         child: CircularProgressIndicator(
    //           color: Colors.green,
    //         ),
    //       ),
    //     );
    //   },
    // );
  }

  Future<void> saveToSharedPreferences(String imageUrl, String title,
      String string, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> wishlist = prefs.getStringList('Wishlist3') ?? [];
    wishlist.add('$imageUrl;$title;$string');
    await prefs.setStringList('Wishlist3', wishlist);

    Timer(
      const Duration(
        milliseconds: 500,
      ),
      () {
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

  Future<void> _shareOnWhatsApp() async {
    final ByteData byteData = await rootBundle.load(widget.assetUrl);
    final Directory? directory1 = await getExternalStorageDirectory();

    final List<int> imageData = byteData.buffer.asUint8List();
    final textImage = await textToImage(widget.title);

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
}
