import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ristekflix/repository/movie_repository.dart';
import 'package:ristekflix/screens/detail_screen.dart';

const String apiKey =
    'a8fe2c893a6c51ef87d21f2c7bc02a26'; // Replace with your TMDb API Key

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
    return SizedBox(
      height: 300,
      child: Column(
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
      ),
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
  final MovieRepository movieRepository = MovieRepository();


  @override
  void initState() {
    super.initState();
    fetchCategoryData();
  }

  Future<void> fetchCategoryData() async {
      final data = await movieRepository.fetchCategoryData(widget.category);
      setState(() {
        items = data['results'];
      });
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

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailScreen(movie: items[index]),
                        ),
                      );
                    },
                    child: Padding(
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
                    ),
                  );
                },
              ),
            ],
          );
  }
}
