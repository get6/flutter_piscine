import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:subject/custom_widget/details_page.dart';

import '../model/conference_data_model.dart';

class ConferencePage extends StatelessWidget {
  const ConferencePage({super.key});

  Future<List<ConferenceDataModel>> _fetchData() async {
    var response = await Client().get(Uri.parse(
        'https://raw.githubusercontent.com/junsuk5/mock_json/main/conferences.json'));
    if (response.statusCode != 200) {
      throw Exception();
    }

    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    List<ConferenceDataModel> conferences = parsed
        .map<ConferenceDataModel>((map) => ConferenceDataModel.fromMap(map))
        .toList();
    return conferences;
  }

  void _buildEventOntap(BuildContext context, ConferenceDataModel conference) =>
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => DetailsPage(conference: conference),
      ));

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final conferences = snapshot.data;
        return ListView.separated(
          separatorBuilder: (context, index) => const Divider(thickness: 1),
          itemCount: conferences!.length,
          itemBuilder: (context, index) {
            final conference = conferences[index];
            return InkWell(
              onTap: () => _buildEventOntap(context, conference),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(
                    conference.name,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    conference.location,
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
