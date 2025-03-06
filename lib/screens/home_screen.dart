import 'package:flutter/material.dart';
import 'package:ristekflix/widgets/category_section.dart';
import 'package:ristekflix/widgets/top_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF5038BC),
      body: Column(
        children: [
          TopBar(),
          Expanded(child: CategorySection()),
        ],
      ),
    );
  }
}