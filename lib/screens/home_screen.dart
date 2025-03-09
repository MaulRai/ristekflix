import 'package:flutter/material.dart';
import 'package:ristekflix/helpers/genres.dart';
import 'package:ristekflix/helpers/user_things.dart';
import 'package:ristekflix/services/firestore_service.dart';
import 'package:ristekflix/widgets/category_section.dart';
import 'package:ristekflix/widgets/special_section.dart';
import 'package:ristekflix/widgets/top_bar.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> preferredGenres = [];
  String chosenGenre = "";
  int chosenGenreNum = -1;
  final FirestoreService firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();
    _listenToUserPreferences();
  }

  void _listenToUserPreferences() {
    firestoreService.getUserDataStream().listen((userData) {
      if (userData != null && mounted) {
        setState(() {
          preferredGenres = userData['preferredGenres'] ?? [];
          _getRandomGenre(); // Update chosen genre when preferences change
        });
      }
    });
  }

  void _getRandomGenre() {
    if (preferredGenres.isNotEmpty) {
      chosenGenre = preferredGenres[Random().nextInt(preferredGenres.length)];
      chosenGenreNum = genreNums[chosenGenre]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF5038BC),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                height: 50,
                width: double.infinity,
                child: Image.asset("assets/images/ristekflix.png"),
              ),
              TopBar(),
              CategorySection(),
              if (preferredGenres.isNotEmpty) ...[
                SizedBox(height: 20),
                SpecialSection(
                  title: "Based on your favorite genre: $chosenGenre",
                  apiUrl:
                      "https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&with_genres=$chosenGenreNum",
                ),
              ],
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
              SizedBox(height: 20),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
