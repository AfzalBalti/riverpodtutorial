import 'package:flutter_application_1/providers/favourite_states.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/model/item.dart';

final favouriteProvider =
    StateNotifierProvider<FavouriteNotifier, FavouriteStates>((ref) {
  return FavouriteNotifier();
});

class FavouriteNotifier extends StateNotifier<FavouriteStates> {
  FavouriteNotifier()
      : super(FavouriteStates(allItems: [], filteredItems: [], search: ''));

  void additems() {
    List<Item> item = [
      Item(name: 'Samsung Galaxy', id: 001, favourite: false),
      Item(name: 'iPhone 15', id: 002, favourite: true),
      Item(name: 'MacBook Pro', id: 003, favourite: false),
      Item(name: 'Dell XPS', id: 004, favourite: true),
      Item(name: 'Google Pixel', id: 005, favourite: false),
    ];
    state =
        state.copyWith(allItems: item.toList(), filteredItems: item.toList());
  }

  void filterlist(String search) {
    state = state.copyWith(filteredItems: _filterItems(state.allItems, search));
  }

  void favourite(String options) {
    state =
        state.copyWith(filteredItems: _favouriteItems(state.allItems, options));
  }

  List<Item> _filterItems(List<Item> items, String search) {
    if (search.isEmpty) {
      return items;
    }

    return items
        .where(
            (items) => items.name.toLowerCase().contains(search.toLowerCase()))
        .toList();
  }

  List<Item> _favouriteItems(List<Item> items, String options) {
    if (options == 'All') {
      return items;
    }

    return items.where((items) => items.favourite == true).toList();
  }
}
