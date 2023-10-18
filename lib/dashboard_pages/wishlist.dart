import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  List<WishlistItem> wishlistItems = [];

  @override
  void initState() {
    super.initState();
    fetchWishlist();
  }

  Future<List<WishlistItem>> fetchWishlist() async {
    final prefs = await SharedPreferences.getInstance();
    final wishlist = prefs.getStringList('Wishlist3') ?? [];

    List<WishlistItem> wishlistItems = wishlist.map((item) {
      final parts = item.split(';');
      return WishlistItem(
          imageUrl: parts[0], title: parts[1], sizeOption: parts[2]);
    }).toList();

    return wishlistItems;
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
        child: FutureBuilder<List<WishlistItem>>(
          future: fetchWishlist(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              Fluttertoast.showToast(msg: "Error Occurred");
              return const Center();
            } else if (snapshot.hasData) {
              final wishlistItems = snapshot.data;

              if (wishlistItems!.isEmpty) {
                return const Center(child: Text('No wishlist items'));
              } else {
                return ListView.builder(
                  itemCount: wishlistItems.length,
                  itemBuilder: (context, index) {
                    return CustomCard(
                      imageUrl: wishlistItems[index].imageUrl,
                      title: wishlistItems[index].title,
                      size: wishlistItems[index].sizeOption,
                      onTap: () {
                        deleteItem(index);
                      },
                    );
                  },
                );
              }
            } else {
              return const Center(child: Text('No wishlist items'));
            }
          },
        ),
      ),
    );
  }

  void deleteItem(int index) async {
    final prefs = await SharedPreferences.getInstance();

    List<WishlistItem> wishlistItems = await fetchWishlist();

    if (index >= 0 && index < wishlistItems.length) {
      wishlistItems.removeAt(index);

      final wishlistStrings = wishlistItems.map((item) {
        return '${item.imageUrl};${item.title};${item.sizeOption}';
      }).toList();

      await prefs.setStringList('Wishlist3', wishlistStrings);

      setState(() {
        wishlistItems = wishlistItems;
      });

      Fluttertoast.showToast(msg: "Item Deleted");
    }
  }
}

class CustomCard extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String size;
  final VoidCallback onTap;

  const CustomCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.onTap,
    required this.size,
  });

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
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
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris",
                      style: TextStyle(
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
    );
  }
}

class WishlistItem {
  final String imageUrl;
  final String title;
  final String sizeOption;

  WishlistItem({
    required this.imageUrl,
    required this.title,
    required this.sizeOption,
  });
}
