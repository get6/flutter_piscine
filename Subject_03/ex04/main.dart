import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:subject/custom_widget/conference_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  final title = 'Conference';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(primaryColor: Colors.white),
      home: Scaffold(
        appBar: AppBar(
          title: Text(title, style: GoogleFonts.lato(color: Colors.black)),
          backgroundColor: Colors.white,
        ),
        body: const ConferencePage(),
      ),
    );
  }
}
