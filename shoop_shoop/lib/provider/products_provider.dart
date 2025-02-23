import 'package:flutter/material.dart';
import '../model/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Products with ChangeNotifier {
  List<Product> _products = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  bool showFavorites = false;
  static const url = 'https://flutter-dummy-df5e9.firebaseio.com';

  List<Product> get products {
    // if (showFavorites)
    //   return [..._products.where((prod) => prod.isFavorite).toList()];
    // else
    return [..._products];
  }

  Future<void> add(Product product) async {
    const addUrl = url + '/products';
    try {
      final response = await http.post(addUrl,
          body: json.encode({
            'description': product.description,
            'title': product.title,
            'price': product.price,
            'imageUrl': product.imageUrl
          }));
      final newProduct = Product(
          description: product.description,
          title: product.title,
          price: product.price,
          imageUrl: product.imageUrl,
          id: json.decode(response.body)['name']);

      _products.add(newProduct);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  void update(Product product) {
    final index = _products.indexWhere((prod) => prod.id == product.id);
    _products[index] = product;
    notifyListeners();
  }

  List<Product> get favorites {
    return [..._products.where((prod) => prod.isFavorite)];
  }

  // void showFavorite() {
  //   showFavorites = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   showFavorites = false;
  //   notifyListeners();
  // }

  void delete(Product product) {
    _products.removeWhere((prod) => prod.id == product.id);
    notifyListeners();
  }

  Product findById(String id) {
    return _products.firstWhere((prod) => prod.id == id);
  }
}
