import 'dart:convert';

import 'package:http/http.dart' as http;

class MovieRepository {
  final String _apiKey = 'a8fe2c893a6c51ef87d21f2c7bc02a26';


  Future<Map> searchMovies(String query) async {
    if (query.isEmpty) return {};

    final url = Uri.parse(
        'https://api.themoviedb.org/3/search/movie?api_key=$_apiKey&query=$query');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<List<dynamic>> fetchMovies(String apiUrl) async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['results'];
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<Map> fetchCategoryData(String category) async {
    String url = '';

    if (category == "movies") {
      url = 'https://api.themoviedb.org/3/trending/movie/week?api_key=$_apiKey';
    } else if (category == "tv") {
      url = 'https://api.themoviedb.org/3/trending/tv/week?api_key=$_apiKey';
    } else if (category == "anime") {
      url =
          'https://api.themoviedb.org/3/discover/tv?api_key=$_apiKey&with_genres=16'; // 16 is the genre ID for Animation
    }

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to load data");
    }
  }
}