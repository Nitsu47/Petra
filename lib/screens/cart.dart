import 'package:flutter/material.dart';
import 'package:petratest/models/product.dart';

// Definición de la clase ShoppingCart que extiende ChangeNotifier
class ShoppingCart extends ChangeNotifier {
  Map<String, Product> _products = {};

  Map<String, Product> get items {
    return {..._products};
  }

  int get productNumber {
    return _products.length;
  }

  double get initialPrice {
    var total = 0.0;
    _products.forEach((key, product) {
      total += product.price * product.quantity;
    });
    return total;
  }

  double get taxes {
    return initialPrice * 0.18;
  }

  double get totalPrice {
    return initialPrice * 1.18;
  }

  void addProduct(String id, String title, double price) {
    if (_products.containsKey(id)) {
      _products.update(
        id,
        (existingProduct) => Product(
          id: existingProduct.id,
          title: existingProduct.title,
          price: existingProduct.price,
          quantity: existingProduct.quantity + 1,
        ),
      );
    } else {
      _products.putIfAbsent(
        id,
        () => Product(
          id: id,
          title: title,
          price: price,
        ),
      );
    }
    notifyListeners();
  }

  void removeProduct(String id) {
    _products.remove(id);
    notifyListeners();
  }

  void clearCart() {
    _products = {};
    notifyListeners();
  }
}
