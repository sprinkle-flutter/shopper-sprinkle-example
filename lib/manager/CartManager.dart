import 'package:sprinkle/Manager.dart';
import 'package:sprinkle/SprinkleExtension.dart';

import '../Item.dart';

class CartManager extends Manager {
  var items = <Item>[].reactive;

  get total =>
      items.value.fold<int>(0, (total, current) => total + current.price);

  get count => items.value.length;

  void add(Item item) {
    // FIXME Use `UnmodifiableListView` to force immutability in the sink
    // it doesn't work with RxDart and I don't know why

    items.value = [...items.value, item];
  }

  void addIfNotAdded(Item item) {
    if (! items.value.contains(item)) {
      items.value.add(item);
      print('- ${items.value}');
    }
  }

  @override
  void dispose() {
  }
}
