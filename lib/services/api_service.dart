import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/cart_item.dart';

class ApiService {
  static const String baseUrl = 'http://192.168.1.12:5000';

  Future<List<CartItem>> fetchCart() async {
    final response = await http.get(Uri.parse('$baseUrl/carrito'));
    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body)['cart'];
      return body.map((dynamic item) => CartItem.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load cart');
    }
  }

  Future<void> addToCart(int index) async {
    final String encodedIndex = Uri.encodeComponent(index.toString());
    final String encodedPath = Uri.encodeComponent('añadir_al_carrito');
    final response = await http.get(Uri.parse('$baseUrl/$encodedPath/$encodedIndex'));
    if (response.statusCode != 200) {
      throw Exception('Failed to add item to cart');
    }
  }

  Future<void> deleteFromCart(String nombre, String color, String talle) async {
    final String encodedNombre = Uri.encodeComponent(nombre);
    final String encodedColor = Uri.encodeComponent(color);
    final String encodedTalle = Uri.encodeComponent(talle);
    final response = await http.get(Uri.parse(
      '$baseUrl/eliminar_producto?Nombre_Producto=$encodedNombre&Color=$encodedColor&Talle=$encodedTalle'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete item from cart');
    }
  }
}
