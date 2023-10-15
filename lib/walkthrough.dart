import 'package:demoapp/mainpage/mainscreen.dart';
import 'package:flutter/material.dart';

class WalkThrough extends StatefulWidget {
  const WalkThrough({Key? key}) : super(key: key);

  @override
  State<WalkThrough> createState() => _WalkThroughState();
}

class _WalkThroughState extends State<WalkThrough> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final List<WalkthroughItem> _walkthroughItems = [
    WalkthroughItem(
      image: 'assets/images/slide2.jpg',
      title: 'Welcome',
      description:
          'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn\'t anything embarrassing hidden in the middle of text.',
    ),
    WalkthroughItem(
      image: 'assets/images/slide1.jpg',
      title: 'Slide 2',
      description:
          'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn\'t anything embarrassing hidden in the middle of text.',
    ),
    WalkthroughItem(
      image: 'assets/images/slide3.jpg',
      title: 'Slide 3',
      description:
          'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn\'t anything embarrassing hidden in the middle of text.',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _walkthroughItems.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const MainScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _walkthroughItems.length,
            itemBuilder: (context, index) {
              final item = _walkthroughItems[index];
              return WalkthroughPage(item: item);
            },
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 18.0),
            child: _buildDots(),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          bottom: 15.0,
          right: 50.0,
          left: 50.0,
        ),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.green.shade300),
          ),
          onPressed: _nextPage,
          child: Text(
            _currentPage == _walkthroughItems.length - 1
                ? 'Let\'s Start'
                : 'Next',
            style: const TextStyle(
              fontSize: 18.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDots() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        _walkthroughItems.length,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          width: 10.0,
          height: 10.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPage == index ? Colors.blue : Colors.grey,
          ),
        ),
      ),
    );
  }
}

class WalkthroughItem {
  final String image;
  final String title;
  final String description;

  WalkthroughItem(
      {required this.image, required this.title, required this.description});
}

class WalkthroughPage extends StatelessWidget {
  final WalkthroughItem item;

  const WalkthroughPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 15.0,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
              12.0,
            ),
            child: Image.asset(
              item.image,
              height: 250.0,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fill,
            ),
          ),
        ),
        const SizedBox(height: 20.0),
        Text(
          item.title,
          style: const TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            item.description,
            style: const TextStyle(
              fontSize: 14.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
