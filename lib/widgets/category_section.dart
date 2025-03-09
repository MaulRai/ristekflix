import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ristekflix/repository/movie_repository.dart';
import 'package:ristekflix/screens/detail_screen.dart';
import 'package:ristekflix/widgets/category_carousel.dart';

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
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color:
                      Colors.white.withOpacity(0.05), // Semi-transparent white
                  width: 1, // Adjust thickness as needed
                ),
              ),
            ),
            child: TabBar(
              controller: _tabController,
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey,
              tabs: const [
                Tab(text: "Movies"),
                Tab(text: "TV Shows"),
                Tab(text: "Animation"),
              ],
            ),
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
