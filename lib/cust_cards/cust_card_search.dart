// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomCard4 extends StatefulWidget {
  final String assetUrl;
  final String title;
  final String description;
  final String productID;
  final String productType;

  const CustomCard4({
    required this.assetUrl,
    required this.title,
    required this.description,
    required this.productID,
    required this.productType,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomCard4> createState() => _CustomCard4State();
}

class _CustomCard4State extends State<CustomCard4> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => DisplayItemPage(
        //       productName: widget.title,
        //       imageUrl: widget.assetUrl,
        //       desc: widget.description,
        //     ),
        //   ),
        // );
        Fluttertoast.showToast(msg: widget.title);
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Card(
          color: Colors.green.shade50,
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    widget.description,
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
                    bottom: 10.0,
                    left: 6.0,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
