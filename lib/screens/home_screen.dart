import 'package:flutter/material.dart';
import 'package:ristekflix/widgets/category_section.dart';
import 'package:ristekflix/widgets/special_section.dart';
import 'package:ristekflix/widgets/top_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF5038BC),
      body: SafeArea(
        child: SingleChildScrollView(
          // Enables vertical scrolling
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopBar(),

              // Limit CategorySection height instead of using Expanded
              SizedBox(
                height: 300,
                child: CategorySection(),
              ),

              SizedBox(height: 20), 
              SpecialSection(
                title: "Top Rated",
                apiUrl:
                    "https://api.themoviedb.org/3/movie/top_rated?api_key=$apiKey",
              ),
              SizedBox(height: 20), 
              SpecialSection(
                title: "On The Air",
                apiUrl:
                    "https://api.themoviedb.org/3/tv/on_the_air?api_key=$apiKey",
              ),
              SizedBox(height: 20), 
              SpecialSection(
                title: "Upcoming",
                apiUrl:
                    "https://api.themoviedb.org/3/movie/upcoming?api_key=$apiKey",
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
