import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String apiKey = 'a8fe2c893a6c51ef87d21f2c7bc02a26'; // Replace with your TMDb API Key

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
    _tabController = TabController(length: 3, vsync: this);
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
            Tab(text: "Animation"),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              CategoryCarousel(category: "movies"),
              CategoryCarousel(category: "tv"),
              CategoryCarousel(category: "anime"),
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
  List<dynamic> items = [];

  @override
  void initState() {
    super.initState();
    fetchCategoryData();
  }

  Future<void> fetchCategoryData() async {
    String url = '';

    if (widget.category == "movies") {
      url = 'https://api.themoviedb.org/3/trending/movie/week?api_key=$apiKey';
    } else if (widget.category == "tv") {
      url = 'https://api.themoviedb.org/3/trending/tv/week?api_key=$apiKey';
    } else if (widget.category == "anime") {
      url = 'https://api.themoviedb.org/3/discover/tv?api_key=$apiKey&with_genres=16'; // 16 is the genre ID for Animation
    }

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        items = data['results'];
      });
    } else {
      throw Exception("Failed to load data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return items.isEmpty
        ? Center(child: CircularProgressIndicator())
        : Column(
            children: [
              CarouselSlider.builder(
                itemCount: items.length,
                options: CarouselOptions(
                  height: 250,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  viewportFraction: 0.6,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
                itemBuilder: (context, index, realIndex) {
                  bool isCurrent = index == _currentIndex;
                  String imageUrl = items[index]['poster_path'] != null
                      ? 'https://image.tmdb.org/t/p/w500${items[index]['poster_path']}'
                      : 'https://via.placeholder.com/500x750';

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: isCurrent
                                ? Colors.white.withOpacity(0.4)
                                : Colors.black.withOpacity(0.5),
                            blurRadius: isCurrent ? 12 : 6,
                            spreadRadius: isCurrent ? 3 : 1,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(imageUrl, fit: BoxFit.cover),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                padding: EdgeInsets.all(8),
                                color: Colors.black.withOpacity(0.7),
                                child: Text(
                                  items[index]['title'] ??
                                      items[index]['name'] ??
                                      "Unknown",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: isCurrent ? 18 : 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
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
