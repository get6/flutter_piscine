import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:subject/custom_widget/moview_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  final title = 'Movie Poster';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHome(title: title),
    );
  }
}

class MyHome extends StatelessWidget {
  const MyHome({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(title, style: GoogleFonts.qwitcherGrypen(fontSize: 40))),
      body: MoviePage(),
    );
  }
}
