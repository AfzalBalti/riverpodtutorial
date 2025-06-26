import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

final counter = StateProvider<int>((ref) {
  return 0;
});
final switchProvider = StateProvider<bool>((ref) {
  return false;
});

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('build');
    return Scaffold(
      appBar: AppBar(title: Text('Counter App')),
      body: Column(
        children: [
          Consumer(builder: (context, ref, child) {
            final count = ref.watch(counter);
            print('build2');
            return Center(
              child: Text(
                count.toString(),
                style: TextStyle(fontSize: 47),
              ),
            );
          }),
          Consumer(builder: (context, ref, child) {
            final count = ref.watch(switchProvider);
            print('build3');
            return Switch(
                value: count,
                onChanged: (value) {
                  ref.read(switchProvider.notifier).state = value;
                });
          }),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    ref.read(counter.notifier).state++;
                  },
                  child: Text('+')),
              ElevatedButton(
                  onPressed: () {
                    ref.read(counter.notifier).state--;
                  },
                  child: Text('-'))
            ],
          )
        ],
      ),
    );
  }
}
