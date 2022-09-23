import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter95/flutter95.dart';
import 'package:http/http.dart';
import 'package:subject/custom_widget/detail_page.dart';

import 'custom_widget/banner95.dart';
import 'custom_widget/text95.dart';
import 'models/post.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'dot_com_board',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: '나우누리에 오신 것을 환영합니다.'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

Future<List<dynamic>> _futureComments() async {
  final response = await Client()
      .get(Uri.parse('https://jsonplaceholder.typicode.com/comments'));
  final decode = json.decode(response.body) as List<dynamic>;
  if (decode.isEmpty) return [];
  return decode;
}

Future<List<Post>> _futureNownuri() async {
  final response = await Client().get(
    Uri.parse("https://jsonplaceholder.typicode.com/posts"),
  );
  final decode = json.decode(response.body) as List<dynamic>;
  if (decode.isEmpty) return [];
  final comments = await _futureComments();
  if (comments.isNotEmpty) {
    for (var post in decode) {
      post['comments'] =
          comments.where((comment) => post['id'] == comment['postId']).toList();
    }
  }
  return decode.map((json) => Post.fromMap(json)).toList();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _futureNownuri(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold95(
            title: widget.title,
            body: const Expanded(
              child: Center(
                  child: CircularProgressIndicator(
                color: Colors.grey,
              )),
            ),
          );
        }
        if (snapshot.hasData) {
          List<Post> posts = snapshot.data!;
          return Scaffold95(
            title: widget.title,
            toolbar: Toolbar95(actions: [
              Item95(
                label: 'File',
                menu: Menu95(
                  items: [
                    MenuItem95(value: 1, label: 'New'),
                    MenuItem95(value: 2, label: 'Open'),
                    MenuItem95(value: 3, label: 'Exit'),
                  ],
                  onItemSelected: (item) {},
                ),
              ),
              const Item95(label: 'Edit'),
              const Item95(label: 'Save'),
            ]),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Column(
                children: [
                  Elevation95(
                    type: Elevation95Type.down,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(height: 4),
                          Image.asset(
                            'assets/images/nownuri.jpeg',
                            width: 200,
                          ),
                          const SizedBox(height: 4),
                          Elevation95(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: const [
                                  Text95(
                                    '1. 안내 / 가입',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  Text95(
                                    '2. 전자우편',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  Text95(
                                    '3. 게시판',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Elevation95(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: const [
                          Text95('번호'),
                          SizedBox(width: 10),
                          Text95('제목'),
                        ],
                      ),
                    ),
                  ),
                  Elevation95(
                    type: Elevation95Type.down,
                    child: SizedBox(
                      height: 300,
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailPage(post: posts[index]),
                              ),
                            ),
                            child: Elevation95(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text95(
                                  '${index + 1} : ${posts[index].title}',
                                  style: const TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Barnner95('▶︎ 전화 접속번호 변경 : 01421 -> 1544-1421'),
                  const SizedBox(height: 10),
                  const Barnner95('▶︎ 웹 커뮤니티의 최강자! 인/터/넷/나/우/누/리'),
                ],
              ),
            ),
          );
        }
        return const Elevation95(child: Center(child: Text95('No data')));
      },
    );
  }
}
