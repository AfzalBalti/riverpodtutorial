import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/favourite_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Homescreen extends ConsumerWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favouritelist = ref.watch(favouriteProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'HomeScreen',
          style: TextStyle(
            color: Colors.red,
            fontSize: 30,
          ),
        ),
        backgroundColor: Colors.yellow,
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
              color: Colors.white,
              onSelected: (value) {
                ref.read(favouriteProvider.notifier).favourite(value);
              },
              itemBuilder: (BuildContext) {
                return const [
                  PopupMenuItem(value: 'All', child: Text('All')),
                  PopupMenuItem(value: 'favourite', child: Text('favourite'))
                ];
              })
        ],
      ),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Search',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              ref.read(favouriteProvider.notifier).filterlist(value);
            },
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: favouritelist.filteredItems.length,
                  itemBuilder: (context, index) {
                    final item = favouritelist.filteredItems[index];
                    return ListTile(
                      title: Text(item.name),
                      trailing: Icon(item.favourite
                          ? Icons.favorite
                          : Icons.favorite_border_outlined),
                    );
                  }))
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            ref.watch(favouriteProvider.notifier).additems();
          },
          child: const Icon(Icons.add)),
    );
  }
}
