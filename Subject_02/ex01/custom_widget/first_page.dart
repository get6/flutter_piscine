import 'package:flutter/material.dart';

import 'second_page.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: _buildAppBar('Second Page'),
            body: _buildBody(const SecondPage()),
          ),
        )),
        child: const Text('Go to Second Page'),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(String title) => AppBar(title: Text(title));

  Widget _buildBody(Widget child) => child;
}
