// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:async';
import 'dart:math';

import 'package:demoapp/display/display_items.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:ui' as ui;

class CustomCardRow extends StatefulWidget {
  final String assetUrl;
  final String title;
  final String desc;

  const CustomCardRow({
    required this.assetUrl,
    required this.title,
    Key? key,
    required this.desc,
  }) : super(key: key);

  @override
  State<CustomCardRow> createState() => _CustomCardRowState();
}

class _CustomCardRowState extends State<CustomCardRow> {
  final random = Random();
  int randomIndex = 0;

  @override
  void initState() {
    super.initState();
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
                desc: widget.desc,
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
                      child: Image.network(
                        widget.assetUrl,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.fitWidth,
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
                        widget.desc,
                        style: const TextStyle(
                          fontSize: 13.0,
                          color: Colors.black87,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
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
                              Fluttertoast.showToast(msg: "Added");
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
