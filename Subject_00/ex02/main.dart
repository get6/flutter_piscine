import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Riverpod 패키지를 사용했기 때문에 pubspec.yaml에 flutter_riverpod을 추가하길 바랍니다.
class Counter extends StateNotifier<int> {
  Counter(this.ref) : super(41);
  final Ref ref;

  void increaseCount() {
    state++;
  }
}

final counterProvider = StateNotifierProvider<Counter, int>((ref) {
  return Counter(ref);
});

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Stateless? or Stateful?'),
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
  PreferredSizeWidget _buildAppBar() => PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(title: Text(widget.title)),
      );

  Widget _buildBody() => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Consumer(
              builder: (context, ref, child) {
                final int counter = ref.watch<int>(counterProvider);
                return Text(
                  '$counter',
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      ?.copyWith(color: Colors.black),
                );
              },
            ),
            const IncrementButton()
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }
}

class IncrementButton extends ConsumerWidget {
  const IncrementButton({Key? key}) : super(key: key);

  final snackBar = const SnackBar(
    content: Text('answer to life the universe and everything'),
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Counter counter = ref.read<Counter>(counterProvider.notifier);
    ref.listen<int>(counterProvider, (previous, next) {
      if (next == 42) {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
    return ElevatedButton(
      onPressed: () {
        counter.increaseCount();
      },
      child: const Text('Add'),
    );
  }
}
