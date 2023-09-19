import 'package:life_management/models/grocery.dart';
import 'package:riverpod/riverpod.dart';

class GroceryNotifier extends StateNotifier<List<Grocery>> {
  GroceryNotifier() : super([]);

  void addGrocery(Grocery grocery) {
    state = [...state, grocery];
  }
  void deleteGrocery(String grocery){
    state = [...state.where((element) => element.name != grocery)];
  }
  void replaceGrocery(String oldGrocery, String newGrocery){
    int oldIndex = state.indexWhere((element) => element.name == oldGrocery); 
    state[oldIndex] = Grocery(name: newGrocery);
  }
}

final groceryList = StateNotifierProvider<GroceryNotifier, List<Grocery>>(
  (ref) => GroceryNotifier(),
);
