import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/cart_item.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String _message = '';
  List<CartItem> _cart = [];

  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    fetchCart();
  }

  Future<void> fetchCart() async {
    try {
      List<CartItem> cart = await apiService.fetchCart();
      setState(() {
        _cart = cart;
      });
    } catch (e) {
      setState(() {
        _message = 'Failed to load cart';
      });
    }
  }

  Future<void> addToCart(int index) async {
    try {
      await apiService.addToCart(index);
      fetchCart();
      setState(() {
        _message = 'Item added to cart';
      });
    } catch (e) {
      setState(() {
        _message = 'Failed to add item to cart';
      });
    }
  }

  Future<void> deleteFromCart(String nombre, String color, String talle) async {
    try {
      await apiService.deleteFromCart(nombre, color, talle);
      fetchCart();
      setState(() {
        _message = 'Item deleted from cart';
      });
    } catch (e) {
      setState(() {
        _message = 'Failed to delete item from cart';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrito de productos'),
      ),
      body: Column(
        children: [
          Text(_message),
          Expanded(
            child: ListView.builder(
              itemCount: _cart.length,
              itemBuilder: (context, index) {
                var item = _cart[index];
                return ListTile(
                  title: Text(item.nombreProducto),
                  subtitle: Text('Cantidad: ${item.cantidad}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => deleteFromCart(item.nombreProducto, item.color, item.talle),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addToCart(1),
        child: const Icon(Icons.add),
      ),
    );
  }
}
