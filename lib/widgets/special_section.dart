import 'package:flutter/material.dart';
import 'package:ristekflix/repository/movie_repository.dart';

import 'package:ristekflix/screens/detail_screen.dart';

class SpecialSection extends StatelessWidget {
  final String title;
  final String apiUrl;
  final MovieRepository movieRepository = MovieRepository();

  SpecialSection({required this.title, required this.apiUrl});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            softWrap: true,
          ),
        ),
        SizedBox(height: 10),

        SizedBox(
          height: 200,
          child: FutureBuilder<List<dynamic>>(
            future: movieRepository.fetchMovies(apiUrl),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text("Failed to load $title"));
              } else {
                final movies = snapshot.data!;
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    final movie = movies[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailScreen(movie: movie),
                          ),
                        );
                      },
                      child: Container(
                        width: 150,
                        margin: EdgeInsets.only(
                            left: index == 0 ? 16 : 8,
                            right: index == movies.length - 1 ? 16 : 8),
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(10),
                          image: movie['poster_path'] != null
                              ? DecorationImage(
                                  image: NetworkImage(
                                      "https://image.tmdb.org/t/p/w500${movie['poster_path']}"),
                                  fit: BoxFit.cover,
                                )
                              : null,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 5,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
