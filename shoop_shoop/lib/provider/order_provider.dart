import 'package:flutter/foundation.dart';
import 'package:shoop_shoop/provider/cart_provider.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime date;

  OrderItem({this.id, this.amount, this.products, this.date});
}

class Order with ChangeNotifier {

  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartProducts, double amount) {
    _orders.insert(0, OrderItem(
      id: DateTime.now().toString(), 
    amount: amount, products: cartProducts, date: DateTime.now()));
    notifyListeners();
  }
  
}