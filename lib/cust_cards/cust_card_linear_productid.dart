// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:io';

import 'package:demoapp/display/display_item_af.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:whatsapp_share/whatsapp_share.dart';

import 'dart:ui' as ui;

class CustomCard3 extends StatelessWidget {
  final String assetUrl;
  final String title;
  final String type;
  final String description;
  final String productID;

  const CustomCard3({
    required this.assetUrl,
    required this.title,
    required this.type,
    required this.description,
    required this.productID,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DisplayItemPage(
              productID: productID,
            ),
          ),
        );
      },
      child: Card(
        color: Colors.white,
        elevation: 0.7,
        margin: const EdgeInsets.only(
          left: 10.0,
          right: 10.0,
          bottom: 12.0,
          top: 20.0,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.asset(
                  assetUrl,
                  width: MediaQuery.of(context).size.width,
                  height: 200.0,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  description,
                  style: const TextStyle(
                    fontSize: 15.0,
                    color: Colors.black87,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10.0,
                  left: 4,
                  bottom: 10.0,
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 5.0),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(
                      10.0,
                    ),
                  ),
                  child: Text(
                    type,
                    style: const TextStyle(
                      fontSize: 15.0,
                      // color: Colors.white,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  _shareOnWhatsApp(
                    assetUrl,
                    title,
                  );
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
        ),
      ),
    );
  }
}

Future<void> _shareOnWhatsApp(String assetUrl, String title) async {
  final ByteData byteData = await rootBundle.load(assetUrl);
  final Directory? directory1 = await getExternalStorageDirectory();

  final List<int> imageData = byteData.buffer.asUint8List();
  final textImage = await textToImage(title);

  if (directory1 != null) {
    final File file2 = File('${directory1.path}/shareable_text.jpg');
    final File file1 = File('${directory1.path}/shareable.jpg');

    try {
      await file1.writeAsBytes(imageData);
      await file2.writeAsBytes(textImage);

      Package package;

      bool? isBusinessWhatsappInstalled =
          await WhatsappShare.isInstalled(package: Package.businessWhatsapp);

      if (isBusinessWhatsappInstalled == true) {
        package = Package.businessWhatsapp;
      } else {
        package = Package.whatsapp;
      }

      await WhatsappShare.shareFile(
        package: package,
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
