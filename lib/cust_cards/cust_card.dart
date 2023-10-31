import 'package:demoapp/display/display_items.dart';
import 'package:flutter/material.dart';

class CustomCard2 extends StatelessWidget {
  final String assetUrl;
  final String title;

  const CustomCard2({
    required this.assetUrl,
    required this.title,
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
                  height: 150.0,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit...",
                  style: TextStyle(
                    fontSize: 13.0,
                    color: Colors.black87,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
