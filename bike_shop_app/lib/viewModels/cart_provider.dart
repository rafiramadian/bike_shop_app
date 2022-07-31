import 'package:bike_shop_app/models/item.dart';
import 'package:flutter/cupertino.dart';

class CartProvider extends ChangeNotifier {
  List<Item> items = [];

  int get total {
    return items.fold(0, (int currentTotal, Item nextItem) {
      return currentTotal + nextItem.hargaItem;
    });
  }

  void addToCart(Item item) {
    items.add(item);
    notifyListeners();
  }

  void removeFromCart(Item item) {
    items.remove(item);
    notifyListeners();
  }
}
