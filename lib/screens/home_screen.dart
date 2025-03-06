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
        child: SingleChildScrollView( // Enables vertical scrolling
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopBar(),

              // Limit CategorySection height instead of using Expanded
              SizedBox(
                height: 300, // Adjust as needed
                child: CategorySection(),
              ),

              SizedBox(height: 20), // Space before SpecialSection
              SpecialSection(),
              SpecialSection(),
            ],
          ),
        ),
      ),
    );
  }
}


