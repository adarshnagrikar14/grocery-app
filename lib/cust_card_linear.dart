import 'package:demoapp/display_items.dart';
import 'package:flutter/material.dart';

class CustomCard3 extends StatelessWidget {
  final String assetUrl;
  final String title;
  final String type;

  const CustomCard3({
    required this.assetUrl,
    required this.title,
    required this.type,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                DisplayItemPage(imageUrl: assetUrl, productName: title),
          ),
        );
      },
      child: Card(
        color: Colors.white,
        elevation: 0.7,
        margin: const EdgeInsets.only(
          left: 10.0,
          right: 10.0,
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
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit...",
                  style: TextStyle(
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
                  top: 8.0,
                  left: 5,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
