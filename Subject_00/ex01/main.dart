import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Riverpod 패키지를 사용했기 때문에 pubspec.yaml에 flutter_riverpod을 추가하길 바랍니다.
class Counter extends StateNotifier<int> {
  Counter(this.ref) : super(0);
  final Ref ref;

  void increaseCount() {
    state++;
  }

  void decreaseCount() {
    state--;
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
      home: const MyHomePage(title: 'Hello Flutter'),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Consumer(builder: (context, ref, child) {
              final int counter = ref.watch<int>(counterProvider);
              return Text(
                '$counter',
                style: Theme.of(context).textTheme.headline4,
              );
            }),
            Consumer(
              builder: (context, ref, child) {
                final Counter counter =
                    ref.read<Counter>(counterProvider.notifier);
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FloatingActionButton(
                      onPressed: counter.increaseCount,
                      tooltip: 'Increment',
                      child: const Icon(Icons.add),
                    ),
                    FloatingActionButton(
                      onPressed: counter.decreaseCount,
                      tooltip: 'Increment',
                      child: const Icon(Icons.remove),
                    )
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
