import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:ristekflix/screens/detail_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _movies = [];
  Timer? _debounce;
  
  // Replace with your TMDB API Key
  final String _apiKey = 'a8fe2c893a6c51ef87d21f2c7bc02a26';

  // Function to fetch movies from TMDB
  Future<void> _searchMovies(String query) async {
    if (query.isEmpty) return;

    final url = Uri.parse(
        'https://api.themoviedb.org/3/search/movie?api_key=$_apiKey&query=$query');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _movies = data['results'];
      });
    } else {
      throw Exception('Failed to load movies');
    }
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
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: "Search movies...",
            border: InputBorder.none,
          ),
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: _movies.isEmpty
          ? Center(child: Text("Search for movies...", style: TextStyle(fontSize: 18)))
          : ListView.builder(
              itemCount: _movies.length,
              itemBuilder: (context, index) {
                final movie = _movies[index];
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
