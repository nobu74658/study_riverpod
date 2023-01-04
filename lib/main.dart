import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_study/todoPage.dart';

final countStateProvider = StateProvider<int>((ref) => 0);
var count = 0;
final countProvider = Provider<int>((ref) {
  // return count;
  final repository = ref.watch(countStateProvider);
  return repository;
});

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: HomePage(),
      home: TodoPage(),
    );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Text(
            "StateProvider${ref.watch(countStateProvider)}",
            style: const TextStyle(fontSize: 32),
          ),
          Text(
            "${ref.watch(countProvider)}",
            style: const TextStyle(fontSize: 32),
          ),
          Text(
            "$count",
            style: TextStyle(fontSize: 32),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(countStateProvider.notifier).state++;
              count++;
              final countProviderRef = ref.read(countProvider);
              print(countProviderRef);
            },
            child: Text("push"),
          ),
        ],
      ),
    );
  }
}
