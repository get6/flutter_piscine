// ignore_for_file:
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:subject/model/conference_data_model.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({
    Key? key,
    required this.conference,
  }) : super(key: key);

  final ConferenceDataModel conference;

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw 'Could not launch $uri';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text('Conferences', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              conference.name,
              style: const TextStyle(fontSize: 30),
            ),
            Text(
              conference.location,
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              '${DateFormat('yMMMMd').format(conference.start)} - ${DateFormat('yMMMMd').format(conference.end)}',
              style: const TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () => _launchUrl(conference.link),
              child: const Text('Go to official website',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.blue)),
            )
          ],
        ),
      ),
    );
  }
}
