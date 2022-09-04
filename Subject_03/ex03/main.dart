import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

import 'model/todo_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  final title = 'Json2Dart';

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
      appBar: AppBar(title: Text(title, style: GoogleFonts.lato())),
      body: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TodoModel? todo;
  void _fetchData() async {
    var response = await Client()
        .get(Uri.parse('https://jsonplaceholder.typicode.com/todos/1'));
    setState(() {
      todo = TodoModel.fromJson(response.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (todo != null)
            Card(
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('title: ${todo!.title}'),
                    Text('userId: ${todo!.userId}'),
                    Text('id: ${todo!.id}'),
                    Text('completed: ${todo!.completed}'),
                  ],
                ),
              ),
            ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _fetchData(),
              child: const Text('Fetch Data'),
            ),
          )
        ],
      ),
    );
  }
}
