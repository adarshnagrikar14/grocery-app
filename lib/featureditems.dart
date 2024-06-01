import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class FeaturedItems2 extends StatelessWidget {
  const FeaturedItems2({Key? key}) : super(key: key);

  Future<List<Map<String, dynamic>>> fetchDepartments() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Link').get();
    return querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.green.shade100,
      ),
      margin: const EdgeInsets.only(
        left: 18.0,
        right: 18.0,
        top: 15.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
              left: 10.0,
            ),
            child: Text(
              "Reports",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                fontFamily: GoogleFonts.tiltNeon().fontFamily,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 0.0, bottom: 10.0),
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: fetchDepartments(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No reports found.'));
                } else {
                  final items = snapshot.data!;
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: items.map((item) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 12.0,
                              ),
                              RoundedImage(
                                imageUrl: item['Url'],
                                onTap: () async {
                                  final Uri uri = Uri.parse(item['Url']);
                                  _launchUri(uri);
                                },
                                size: 55,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 7.0,
                                  left: 8.0,
                                ),
                                child: SizedBox(
                                  width: 100.0,
                                  child: Center(
                                    child: Text(
                                      item['Title'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 1,
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchUri(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }
}

class RoundedImage extends StatelessWidget {
  final String imageUrl;
  final VoidCallback onTap;
  final double size;

  const RoundedImage({
    Key? key,
    required this.imageUrl,
    required this.onTap,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size / 2),
        child: Image.asset(
          "assets/images/pdf.webp",
          width: size,
          height: size,
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}
