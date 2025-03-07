import 'package:flutter/material.dart';
import 'package:ristekflix/helpers/genres.dart';

class DetailScreen extends StatelessWidget {
  final Map<String, dynamic> movie;

  DetailScreen({required this.movie});

  @override
  Widget build(BuildContext context) {
    final String imageUrl = movie['poster_path'] != null
        ? 'https://image.tmdb.org/t/p/w500${movie['poster_path']}'
        : 'https://via.placeholder.com/500x750';
    return Scaffold(
      backgroundColor: Color(0xFF5038BC),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width * 1.2,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Color(0xFF5038BC), // Fading into 5038BC
                    Color(0xFF5038BC), // Fading into 5038BC
                  ],
                  stops: [0.4, 0.6, 1.0], // Smooth transition
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 1.2,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        Text(
                          movie["title"] ?? movie["name"] ?? "Unknown Title",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.yellow, size: 18),
                            SizedBox(width: 5),
                            Text(
                              "${movie["vote_average"] ?? "N/A"} / 10",
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            SizedBox(width: 15),
                            Icon(Icons.how_to_vote, color: Colors.grey, size: 18),
                            SizedBox(width: 5),
                            Text(
                              "${movie["vote_count"] ?? 0} votes",
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Wrap(
                          spacing: 8,
                          children: (movie["genre_ids"] as List<dynamic>?)
                                  ?.map((id) => Chip(
                                        label: Text(genreMap[id] ?? "Unknown"),
                                        backgroundColor: Colors.white24,
                                        labelStyle: TextStyle(color: Colors.black),
                                      ))
                                  .toList() ??
                              [],
                        ),
                        SizedBox(height: 15),
                        Text(
                          movie["overview"] ?? "No description available.",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 40, // Adjust for status bar
            left: 16,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white, // White background
                shape: BoxShape.circle, // Circular shape
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 4,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: IconButton(
                icon: Icon(Icons.arrow_back,
                    color: Color(0xFF5038BC)), // Purple icon
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
