import 'package:flutter/material.dart';

class Product {
  final String id;
  final String title;
  final double price;
  int quantity;

  Product({
    required this.id,
    required this.title,
    required this.price,
    this.quantity = 1,
  });
}
