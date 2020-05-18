import 'package:flutter/cupertino.dart';
import 'package:shoop_shoop/widget/cart_item.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem(
      {@required this.id,
      @required this.title,
      @required this.quantity,
      @required this.price});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};
  int get count {
    return _items.length;
  }

  Map<String, CartItem> get items {
    return {..._items};
  }

  double get total {
    var total = 0.0;
    _items.forEach((key, item) {
      total += item.price * item.quantity;
    });
    return total;
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void addItem(String id, String title, double price) {
    if (_items.containsKey(id)) {
      _items.update(
          id,
          (item) => CartItem(
              id: id, title: title, price: price, quantity: item.quantity + 1));
    } else {
      _items.putIfAbsent(
          id, () => CartItem(id: id, title: title, price: price, quantity: 1));
    }
    notifyListeners();
  }

  void removeSingleItem(String id) {
    if (!_items.containsKey(id)) return;
    if (_items[id].quantity > 1)
      _items.update(
          id,
          (item) => CartItem(
              id: item.id,
              price: item.price,
              quantity: item.quantity - 1,
              title: item.title));
    else
      removeItem(id);
      notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
