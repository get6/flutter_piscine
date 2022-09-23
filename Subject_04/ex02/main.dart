import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:subject/models/my_data.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'my_database',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'My Database'),
    );
  }
}

final db = FirebaseFirestore.instance;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<MyData> futureMyData() async {
    final docRef = db.collection('PROFILE').doc("myData");
    final docSnapshot = await docRef.get();
    final data = docSnapshot.data() as Map<String, dynamic>;
    return MyData.fromMap(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<MyData>(
        future: futureMyData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final myData = snapshot.data!;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    myData.banana,
                    style: const TextStyle(fontSize: 30),
                  ),
                  Text(
                    myData.melon,
                    style: const TextStyle(fontSize: 30),
                  ),
                  Text(
                    myData.pineapple,
                    style: const TextStyle(fontSize: 30),
                  ),
                  Text(
                    myData.apple,
                    style: const TextStyle(fontSize: 30),
                  ),
                ],
              ),
            );
          }
          if (snapshot.hasError) {
            return const Center(child: Text("Oops, an error occurred."));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
