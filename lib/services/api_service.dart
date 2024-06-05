import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/cart_item.dart';

class ApiService {
  static const String baseUrl = 'http://2800:a4:1eb5:800:40e2:227c:31ce:de4e:5000';

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
    final response = await http.get(Uri.parse('$baseUrl/a%C3%B1adir_al_carrito/$index'));
    if (response.statusCode != 200) {
      throw Exception('Failed to add item to cart');
    }
  }

  Future<void> deleteFromCart(String nombre, String color, String talle) async {
    final response = await http.get(Uri.parse(
      '$baseUrl/eliminar_producto?Nombre_Producto=$nombre&Color=$color&Talle=$talle'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete item from cart');
    }
  }
}
