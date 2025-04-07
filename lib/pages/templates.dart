import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MyTemplates extends StatefulWidget {
  const MyTemplates({super.key});

  @override
  State<MyTemplates> createState() => _MyTemplatesState();
}

class _MyTemplatesState extends State<MyTemplates> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> templates = [
    'https://cdn.pixabay.com/photo/2019/06/25/04/01/wedding-4297343_1280.jpg',
    'https://cdn.pixabay.com/photo/2021/02/15/13/04/couple-6017739_1280.jpg',
    'https://cdn.pixabay.com/photo/2025/03/24/06/51/pre-wedding-9490176_1280.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilih Template'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                PageView.builder(
                  controller: _pageController,
                  itemCount: templates.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          templates[index],
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    );
                  },
                ),
                Positioned(
                  bottom: 30,
                  child: SmoothPageIndicator(
                    controller: _pageController,
                    count: templates.length,
                    effect: WormEffect(
                      dotHeight: 10,
                      dotWidth: 10,
                      spacing: 8,
                      activeDotColor: Colors.blue,
                      dotColor: Colors.grey.shade300,
                    ),
                  ),
                ),
                Positioned(
                  top: 30,
                  right: 20,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      '← Swipe →',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Template ${_currentPage + 1} dipilih')),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Pilih design ini'),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
