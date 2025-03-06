import 'package:flutter/material.dart';

class SpecialSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Top 5 Movies",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 10), // Space between title and list

        // Horizontal List
        SizedBox(
          height: 200, // Adjusted height for 3:4 aspect ratio posters
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5, // 5 placeholder posters
            itemBuilder: (context, index) {
              return Container(
                width: 150, // 3:4 Aspect Ratio (150 width, 200 height)
                margin: EdgeInsets.only(left: index == 0 ? 16 : 8, right: index == 4 ? 16 : 8),
                decoration: BoxDecoration(
                  color: Colors.grey[800], // Placeholder color
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 5,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    "Movie ${index + 1}",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
