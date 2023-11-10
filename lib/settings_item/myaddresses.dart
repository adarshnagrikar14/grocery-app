import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAddresses extends StatefulWidget {
  const MyAddresses({super.key});

  @override
  State<MyAddresses> createState() => _MyAddressesState();
}

class _MyAddressesState extends State<MyAddresses> {
  late TextEditingController addressController;
  late List<String> addresses;

  @override
  void initState() {
    super.initState();
    addressController = TextEditingController();
    addresses = [];
    loadAddresses();
  }

  @override
  void dispose() {
    addressController.dispose();
    super.dispose();
  }

  Future<void> loadAddresses() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      addresses = prefs.getStringList('addresses') ?? [];
    });
  }

  Future<void> saveAddress(String newAddress) async {
    final prefs = await SharedPreferences.getInstance();
    addresses.add(newAddress);
    prefs.setStringList('addresses', addresses);
    loadAddresses();
  }

  Future<void> deleteAddress(int index) async {
    final prefs = await SharedPreferences.getInstance();
    addresses.removeAt(index);
    prefs.setStringList('addresses', addresses);
    loadAddresses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Addresses"),
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 12.0,
              top: 2.0,
              bottom: 2.0,
            ),
            child: InkWell(
              onTap: () {},
              child: const Icon(
                Icons.add,
                size: 32.0,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: addresses.isEmpty
                ? const Center(
                    child: Text("No Saved Addresses."),
                  )
                : ListView.builder(
                    itemCount: addresses.length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(
                              12.0,
                            )),
                        margin: const EdgeInsets.all(
                          10.0,
                        ),
                        child: ListTile(
                          title: Text(addresses[index]),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => deleteAddress(index),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          right: 10.0,
          bottom: 10.0,
        ),
        child: FloatingActionButton(
          backgroundColor: Colors.green.shade100,
          onPressed: () => _showAddAddressDialog(context),
          child: const Icon(
            Icons.add,
            size: 32.0,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  void _showAddAddressDialog(BuildContext context) {
    TextEditingController addressController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Enter Address'),
          content: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: TextField(
              controller: addressController,
              decoration: const InputDecoration(hintText: 'Enter Address here'),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (addressController.text.isNotEmpty) {
                  saveAddress(addressController.text);
                  Navigator.pop(context);
                } else {
                  Fluttertoast.showToast(msg: "Enter Address Please.");
                }
              },
              child: const Text('Save Address'),
            ),
          ],
        );
      },
    );
  }
}
