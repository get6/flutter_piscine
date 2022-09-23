// ignore_for_file:
import 'package:flutter/material.dart';
import 'package:flutter95/flutter95.dart';

import 'text95.dart';

class Barnner95 extends StatelessWidget {
  final String title;
  const Barnner95(
    this.title, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Elevation95(
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Text95(
            title,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
