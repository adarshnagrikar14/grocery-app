import 'package:demoapp/display_items.dart';
import 'package:demoapp/types/container.dart';
import 'package:demoapp/types/plates.dart';
import 'package:demoapp/types/tissues.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController _searchController;
  late FocusNode _searchFocusNode;

  @override
  void initState() {
    super.initState();
    _searchFocusNode = FocusNode();
    _searchController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_searchFocusNode);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void clearSearch() {
    setState(() {
      _searchController.clear();
    });
  }

  final List<String> crockeryList = [
    'Plates',
    'Tissues',
    'Container',
    "New buffet 14 printed: multi coloured",
    "Top and Town 8 No: silver",
    "Elite paper plate 10: multi coloured",
    "Elite paper plate 7 no: multi coloured Medium size",
    "Sweet heart 235: white",
    "Top and town 6 no: silver",
    "New buffet 14 printed: multi coloured",
    "Elite paper plate 9 no: multi coloured",
    "Elite paper plates 7 no: multi coloured",
    "New buffet 12 printed: multi coloured",
    "Top and town 9 no: silver Large size",
    "Elite paper plate 9 no: multi coloured",
    "First choice 235 plate: multi coloured",
    "New buffet 10 printed: multi coloured",
    "Elite paper plate 10 no: white",
    "Sweet heart 305 mm: multi coloured"
  ];

  List<String> searchResults = [];

  void search(String query) {
    if (query.isEmpty) {
      setState(() {
        searchResults.clear();
      });
      return;
    }

    final List<String> results = crockeryList
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();

    setState(() {
      searchResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 16.0,
                bottom: 20.0,
              ),
              child: TextField(
                controller: _searchController,
                focusNode: _searchFocusNode,
                onChanged: (text) {
                  search(text);
                },
                decoration: InputDecoration(
                  hintText: 'Search Crockery',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      clearSearch();
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(searchResults[index]),
                    onTap: () {
                      if (searchResults[index] == "Plates") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const PlatesPage(type: "Plates"),
                          ),
                        );
                      } else if (searchResults[index] == "Tissues") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const TissuePage(type: "Tissues"),
                          ),
                        );
                      } else if (searchResults[index] == "Container") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const ContainerPage(type: "Containers"),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DisplayItemPage(
                              imageUrl: "assets/images/tissue2.jpg",
                              productName: searchResults[index],
                            ),
                          ),
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
