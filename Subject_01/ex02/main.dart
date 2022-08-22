// ignore_for_file:
import 'dart:math';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const title = 'ex02';
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: const MyHomePage(title: title),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _suggestions = <WordPair>[];
  final _saved = <WordPair>{};
  final _status = [];
  final _biggerFont = const TextStyle(fontSize: 18);

  Widget _wordTile(WordPair wordPair, bool status, bool alreadySaved) {
    return Card(
      child: ListTile(
        title: Text(wordPair.asPascalCase, style: _biggerFont),
        subtitle: Text(status ? 'Done' : 'Do not yet'),
        trailing: IconButton(
          icon: Icon(alreadySaved ? Icons.favorite : Icons.favorite_outline),
          color: alreadySaved ? Colors.red : null,
          onPressed: () {
            setState(() {
              if (alreadySaved) {
                _saved.remove(wordPair);
              } else {
                _saved.add(wordPair);
              }
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(15),
        itemBuilder: (context, index) {
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
            _status.addAll(List.generate(10, (index) => Random().nextBool()));
          }
          final alreadySaved = _saved.contains(_suggestions[index]);

          return _wordTile(
            _suggestions[index],
            _status[index],
            alreadySaved,
          );
        },
      ),
    );
  }
}
