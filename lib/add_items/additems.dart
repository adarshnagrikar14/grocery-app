// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:chips_choice/chips_choice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demoapp/dashboard_pages/dashboard.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class AddItems extends StatefulWidget {
  const AddItems({super.key});

  @override
  State<AddItems> createState() => _AddItemsState();
}

class _AddItemsState extends State<AddItems> {
  TextEditingController productNameTC = TextEditingController();
  TextEditingController productDescriptionTC = TextEditingController();
  String? _downloadUrl;

  List<String> selectedProductType = [];
  final List<String> optionProductType = [
    "Featured",
    "More",
    "Fresh",
    "All",
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Items"),
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 25.0,
                left: 20.0,
              ),
              child: Text(
                "Product Name",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0,
                  fontFamily: GoogleFonts.tiltNeon().fontFamily,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 18.0,
                left: 18.0,
                right: 18.0,
              ),
              child: TextField(
                controller: productNameTC,
                decoration: InputDecoration(
                  labelText: "Enter Product Name",
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.green,
                      width: 1.2,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            const Space(top: 20, bottom: 1),
            Padding(
              padding: const EdgeInsets.only(
                top: 25.0,
                left: 20.0,
              ),
              child: Text(
                "Product Description",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0,
                  fontFamily: GoogleFonts.tiltNeon().fontFamily,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 18.0,
                left: 18.0,
                right: 18.0,
              ),
              child: TextField(
                controller: productDescriptionTC,
                maxLines: null,
                minLines: 3,
                decoration: InputDecoration(
                  labelText: "Enter Product Description",
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.green,
                      width: 1.2,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            const Space(top: 20, bottom: 1),
            Padding(
              padding: const EdgeInsets.only(
                top: 25.0,
                left: 20.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Product Image",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17.0,
                      fontFamily: GoogleFonts.tiltNeon().fontFamily,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () => _pickImage(),
                    child: const Icon(
                      Icons.upload_file,
                      size: 80,
                    ),
                  ),
                ],
              ),
            ),
            const Space(top: 20, bottom: 1),
            Padding(
              padding: const EdgeInsets.only(
                top: 25.0,
                left: 20.0,
              ),
              child: Text(
                "Product Type",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0,
                  fontFamily: GoogleFonts.tiltNeon().fontFamily,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 12.0,
                left: 20.0,
                right: 20.0,
              ),
              child: Text(
                "Select the One that Applies.",
                style: TextStyle(
                  fontSize: 15.0,
                  fontFamily: GoogleFonts.tiltNeon().fontFamily,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                top: 12.0,
                left: 5.0,
                right: 18.0,
              ),
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              child: ChipsChoice<String>.single(
                value: selectedProductType.isNotEmpty
                    ? selectedProductType[0]
                    : null,
                onChanged: (val) {
                  setState(() {
                    selectedProductType = [val];
                  });
                },
                choiceStyle: C2ChipStyle.filled(
                  color: Colors.black12,
                  checkmarkColor: Colors.green.shade900,
                  selectedStyle: C2ChipStyle.filled(
                    color: Colors.green.shade100,
                  ),
                ),
                choiceCheckmark: true,
                wrapped: true,
                spacing: 20.0,
                alignment: WrapAlignment.spaceBetween,
                choiceItems: C2Choice.listFrom<String, String>(
                  source: optionProductType,
                  value: (i, v) => v,
                  label: (i, v) => v,
                ),
              ),
            ),
            const Space(top: 20, bottom: 1),
            Padding(
              padding: const EdgeInsets.only(
                top: 28.0,
                left: 10,
                right: 10.0,
              ),
              child: RoundedBorderButton(
                onTap: () => insertData(),
                text: "Upload Item",
              ),
            ),
            const SizedBox(
              height: 100.0,
            )
          ],
        ),
      ),
    );
  }

  void insertData() async {
    if (_downloadUrl!.isEmpty) return;

    if (selectedProductType.isEmpty) {
      Fluttertoast.showToast(msg: "Please select a product type.");
      return;
    }

    String collectionName = selectedProductType[0];

    String title = productNameTC.text;
    String description = productDescriptionTC.text;

    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection(collectionName);

    await collectionRef.add({
      'Title': title,
      'Url': _downloadUrl,
      'Description': description,
    });

    Fluttertoast.showToast(msg: "Item uploaded successfully.");

    setState(() {
      productNameTC.clear();
      productDescriptionTC.clear();
      selectedProductType.clear();
    });
  }

  File? _image;

  Future<void> _pickImage() async {
    if (await Permission.photos.request().isGranted ||
        await Permission.storage.request().isGranted) {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
        _uploadImage();
      }
    } else {
      Fluttertoast.showToast(msg: "Please Grant Permisiion");
      Navigator.pop(context);
    }
  }

  Future<void> _uploadImage() async {
    if (_image == null) return;

    try {
      String fileName = _image!.path.split('/').last;
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child('uploads/$fileName');
      UploadTask uploadTask = ref.putFile(_image!);

      TaskSnapshot snapshot = await uploadTask;
      _downloadUrl = await snapshot.ref.getDownloadURL();

      setState(() {
        _downloadUrl = _downloadUrl;
      });

      Fluttertoast.showToast(msg: "Image Uploaded");
    } catch (e) {
      Fluttertoast.showToast(msg: "Error Uploading Image");
      Navigator.pop(context);
    }
  }
}
