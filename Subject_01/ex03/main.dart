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
  final _words = <Word>[];
  final _biggerFont = const TextStyle(fontSize: 18);

  Widget _wordTile(Word word, int index) {
    return Card(
      child: ListTile(
        title: Text(word.wordPair.asPascalCase, style: _biggerFont),
        subtitle: Text(word.status ? 'Done' : 'Do not yet'),
        trailing: IconButton(
          icon: Icon(word.saved ? Icons.favorite : Icons.favorite_outline),
          color: word.saved ? Colors.red : null,
          onPressed: () {
            final int wordIndex = _words.indexOf(word);
            if (wordIndex == -1) return;
            setState(() {
              _words[wordIndex] = word.copyWith(saved: !word.saved);
            });
          },
        ),
      ),
    );
  }

  Widget showBackground(int direction) => Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        color: Colors.red,
        child: Row(
          mainAxisAlignment:
              direction == 0 ? MainAxisAlignment.start : MainAxisAlignment.end,
          children: [
            const Icon(
              Icons.delete,
              size: 30,
              color: Colors.white,
            ),
            const SizedBox(width: 5),
            Text(
              'REMOVE',
              style: _biggerFont.copyWith(color: Colors.white),
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(15),
        itemBuilder: (context, index) {
          if (index >= _words.length) {
            _words.addAll(generateWord(10));
          }
          final word = _words[index];

          return Dismissible(
              key: ValueKey(word.wordPair),
              background: showBackground(0),
              secondaryBackground: showBackground(1),
              onDismissed: (direction) {
                _words.remove(word);
              },
              child: _wordTile(word, index));
        },
      ),
    );
  }

  List<Word> generateWord(int length) {
    List<WordPair> pairs = generateWordPairs().take(length).toList();
    return List<Word>.generate(
      length,
      (index) => Word(
        wordPair: pairs[index],
        status: Random().nextBool(),
        saved: false,
      ),
    );
  }
}

class Word {
  final WordPair wordPair;
  final bool status;
  final bool saved;

  Word({
    required this.wordPair,
    required this.status,
    required this.saved,
  });

  Word copyWith({
    String? id,
    WordPair? wordPair,
    bool? status,
    bool? saved,
  }) {
    return Word(
      wordPair: wordPair ?? this.wordPair,
      status: status ?? this.status,
      saved: saved ?? this.saved,
    );
  }
}
