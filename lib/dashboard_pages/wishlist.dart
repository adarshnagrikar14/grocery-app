import 'package:demoapp/cust_cards/cust_card_row.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  List<Map<String, String>> cartItems = [];

  @override
  void initState() {
    super.initState();
    _loadCartItems();
  }

  Future<void> _loadCartItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? cartList = prefs.getStringList('cartList');
    if (cartList != null) {
      setState(() {
        cartItems = cartList
            .map((item) => Map<String, String>.from(jsonDecode(item)))
            .toList();
      });
    }
  }

  Future<void> clearCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('cartList');
    setState(() {
      cartItems.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Your Cart",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: GestureDetector(
              onTap: () => clearCart(),
              child: const Row(
                children: [
                  Text("Clear All\t"),
                  Icon(
                    Icons.delete,
                    size: 25,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: cartItems.isEmpty
          ? const Center(
              child: Text("No Cart Item"),
            )
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return CustomCardRow(
                  title: item['pName']!,
                  assetUrl: item['pUrl']!,
                  desc: item['pDesc']!,
                );
              },
            ),
    );
  }
}
