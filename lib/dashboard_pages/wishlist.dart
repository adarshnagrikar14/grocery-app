import 'package:flutter/material.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  void initState() {
    super.initState();
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
      body: const Center(
        child: Text("No wishlist Item"),
      ),
    );
  }
}
