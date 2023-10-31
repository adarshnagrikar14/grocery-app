import 'dart:convert';

import 'package:demoapp/display/display_items.dart';
import 'package:demoapp/wishlist/wishlist_af.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class WishlistPage extends StatefulWidget {
  const WishlistPage({Key? key}) : super(key: key);

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class WishlistItem {
  final String imageUrl;
  final String title;
  final String sizeOption;
  final String description;
  final String timeStamp;

  WishlistItem({
    required this.imageUrl,
    required this.title,
    required this.sizeOption,
    required this.description,
    required this.timeStamp,
  });
}

class _WishlistPageState extends State<WishlistPage> {
  List<WishlistItem> wishlistItems = [];

  late bool isAllowedToShow;

  @override
  void initState() {
    super.initState();

    isAllowedToShow = false;
    fetchWishlistFromAPI();
  }

  Future<List<WishlistItem>> fetchWishlistFromAPI() async {
    wishlistItems = [];
    try {
      setState(() {
        isAllowedToShow = false;
      });
      final response = await http.post(
        Uri.parse(
          "https://assignme-work.000webhostapp.com/venus/fetchwishlist.php",
        ),
        body: {
          'userID': FirebaseAuth.instance.currentUser!.uid,
        },
      );

      setState(() {
        isAllowedToShow = true;
      });

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final List<WishlistItem> wishlistItems = data.map((item) {
          return WishlistItem(
            imageUrl: item['ImageLink'],
            title: item['ProductName'],
            sizeOption: item['ProductSize'],
            description: item['ProductDescription'],
            timeStamp: item['TimeStamp'],
          );
        }).toList();

        setState(() {
          this.wishlistItems = wishlistItems;
        });

        return wishlistItems;
      } else {
        Fluttertoast.showToast(msg: "Failed to get wishlist");
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Your wishlist",
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Stack(children: [
          Visibility(
            visible: isAllowedToShow,
            child: _buildWishlist(),
          ),
          Visibility(
            visible: !isAllowedToShow,
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 100.0,
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _buildWishlist() {
    if (wishlistItems.isEmpty) {
      return const Center(child: Text('No wishlist items'));
    } else {
      return ListView.builder(
        itemCount: wishlistItems.length,
        itemBuilder: (context, index) {
          return CustomCard(
            imageUrl: wishlistItems[index].imageUrl,
            title: wishlistItems[index].title,
            size: wishlistItems[index].sizeOption,
            desc: wishlistItems[index].description,
            onTap: () {
              deleteItem(index);
            },
            onCardTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DisplayItemPage(
                    imageUrl: wishlistItems[index].imageUrl,
                    productName: wishlistItems[index].title,
                  ),
                ),
              );
            },
          );
        },
      );
    }
  }

  void deleteItem(int index) async {
    String result = await deleteItemFromDB(wishlistItems[index].timeStamp);

    if (result == "Success") {
      Fluttertoast.showToast(msg: "Item Deleted.");
      fetchWishlistFromAPI();
    } else {
      Fluttertoast.showToast(msg: "Failed to delete. Retry");
      fetchWishlistFromAPI();
    }
  }
}

class CustomCard extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String size;
  final String desc;
  final VoidCallback onTap;
  final VoidCallback onCardTap;

  const CustomCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.onTap,
    required this.size,
    required this.desc,
    required this.onCardTap,
  });

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.onCardTap(),
      child: Card(
        color: Colors.white,
        elevation: 2.0,
        margin: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.asset(
                    widget.imageUrl,
                    width: MediaQuery.of(context).size.width,
                    height: 100.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "${widget.title} (${widget.size})",
                        style: const TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Text(
                        widget.desc,
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black45,
                        ),
                        maxLines: 2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 10.0,
                        top: 8.0,
                        left: 8.0,
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
                    Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                        onTap: () => widget.onTap(),
                        child: const Padding(
                          padding: EdgeInsets.only(
                            bottom: 12.0,
                            left: 8.0,
                            right: 12.0,
                          ),
                          child: Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                            size: 25.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
