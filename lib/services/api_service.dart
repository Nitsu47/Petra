import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/cart_item.dart';

class ApiService {
  static const String baseUrl = 'http://192.168.1.160:5000';

  Future<List<CartItem>> fetchCart() async {
    final response = await http.get(Uri.parse('$baseUrl/carrito'));
    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      // Verificar el contenido del cuerpo de la respuesta
      print("Respuesta del servidor: $body");  // Añade esto
      return body.skip(1).map((dynamic item) => CartItem.fromJson(item)).toList();
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

  Future<void> deleteFromCart(String nombre) async {
    final response = await http.get(Uri.parse(
      '$baseUrl/eliminar_producto?name=$nombre'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete item from cart');
    }
  }
}
