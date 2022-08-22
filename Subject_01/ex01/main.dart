// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = 'ex01';
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.red,
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
  Widget greyStar({double size = 40}) => Icon(
        Icons.star,
        color: Colors.grey[600],
        size: size,
      );

  @override
  Widget build(BuildContext context) {
    const double tableHeight = 180;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Table(
            border: TableBorder.symmetric(inside: const BorderSide(width: 5)),
            children: [
              TableRow(
                children: [
                  TableCell(
                    child: Container(
                      height: tableHeight,
                      child: Flex(
                        mainAxisAlignment: MainAxisAlignment.center,
                        direction: Axis.horizontal,
                        children: [
                          greyStar(),
                          Flex(
                            mainAxisAlignment: MainAxisAlignment.center,
                            direction: Axis.vertical,
                            children: [
                              greyStar(),
                              greyStar(size: 100),
                              greyStar(),
                            ],
                          ),
                          greyStar(),
                        ],
                      ),
                    ),
                  ),
                  TableCell(
                    child: Container(
                      height: tableHeight / 2,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.bottom,
                    child: Container(
                      height: tableHeight / 1.5,
                      color: Colors.green,
                    ),
                  ),
                  TableCell(
                    child: Container(
                      padding: const EdgeInsets.only(top: 30),
                      height: tableHeight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 150,
                            height: 50,
                            color: Colors.amber,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.yellow,
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.brown,
            ),
          )
        ],
      ),
    );
  }
}
