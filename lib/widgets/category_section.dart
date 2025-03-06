import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CategorySection extends StatefulWidget {
  @override
  _CategorySectionState createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey,
          tabs: [
            Tab(text: "Movies"),
            Tab(text: "TV Shows"),
            Tab(text: "Anime"),
            Tab(text: "My List"),
          ],
        ),
        // Wrap TabBarView with Expanded to prevent infinite height issue
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              CategoryCarousel(category: "Movies"),
              CategoryCarousel(category: "TV Shows"),
              CategoryCarousel(category: "Anime"),
              CategoryCarousel(category: "My List"),
            ],
          ),
        ),
      ],
    );
  }
}

class CategoryCarousel extends StatefulWidget {
  final String category;
  CategoryCarousel({required this.category});

  @override
  _CategoryCarouselState createState() => _CategoryCarouselState();
}

class _CategoryCarouselState extends State<CategoryCarousel> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: 5, // Adjust number of items
          options: CarouselOptions(
            height: 250,
            enlargeCenterPage: true, // Center item is larger
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            viewportFraction: 0.6, // Adjusts left & right item visibility
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          itemBuilder: (context, index, realIndex) {
            bool isCurrent = index == _currentIndex; // Check if it's the center item
            return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeOut,
                margin: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[800], // Placeholder color
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: isCurrent ? Colors.white.withOpacity(0.4) : Colors.black.withOpacity(0.5),
                      blurRadius: isCurrent ? 12 : 6, // Highlight center item more
                      spreadRadius: isCurrent ? 3 : 1,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    "${widget.category} ${index + 1}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isCurrent ? 20 : 16, // Larger text for center item
                      fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
