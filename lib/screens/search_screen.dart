import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ristekflix/repository/movie_repository.dart';

import 'package:ristekflix/screens/detail_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _movies = [];
  Timer? _debounce;
  final MovieRepository movieRepository = MovieRepository();

  Future<void> _searchMovies(String query) async {
    final data = await movieRepository.searchMovies(query);
    if (data.isEmpty) return;
    setState(() {
      _movies = data['results'];
    });
  }

  // Debounce to reduce API calls
  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _searchMovies(_searchController.text);
    });
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF5038BC),
        title: Padding(
          padding: EdgeInsets.only(bottom: 8), // Adds padding at the bottom
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: "Search movies...",
                    hintStyle: TextStyle(color: Colors.white),
                    border: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey), // Grey underline
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors
                              .grey), // Grey underline when not focused
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color:
                              Colors.white), // White underline when focused
                    ),
                  ),
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              SizedBox(width: 8), // Adds spacing
              Icon(Icons.search, color: Colors.white), // Search icon
            ],
          ),
        ),
      ),
      body: _movies.isEmpty
          ? Center(
              child:
                  Text("Search for movies...", style: TextStyle(fontSize: 18)))
          : ListView.builder(
              itemCount: _movies.length,
              itemBuilder: (context, index) {
                final movie = _movies[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(movie: movie),
                      ),
                    );
                  },
                  child: ListTile(
                    leading: movie['poster_path'] != null
                        ? Image.network(
                            'https://image.tmdb.org/t/p/w92${movie['poster_path']}',
                            width: 50,
                            fit: BoxFit.cover,
                          )
                        : Icon(Icons.movie, size: 50),
                    title: Text(movie['title']),
                    subtitle: Text(movie['release_date'] ?? "Unknown"),
                  ),
                );
              },
            ),
    );
  }
}
