import 'package:flutter/material.dart';
import 'package:petratest/screens/Pedido_screen.dart';
import '../services/api_service.dart';
import '../models/cart_item.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

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

  void fetchCart() async {
    try {
      final items = await apiService.fetchCart();
      if (mounted) {
        setState(() {
          _cart = items;
          _message = _cart.isEmpty ? 'El carrito está vacío' : '';
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _message = 'Error al cargar el carrito: $e';
        });
      }
    }
  }

  void deleteFromCart(String nombre) async {
    try {
      await apiService.deleteFromCart(nombre);
      if (mounted) {
        setState(() {
          _cart.removeWhere((item) => item.nombreProducto == nombre);
          _message = 'Producto eliminado del carrito';
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _message = 'Error al eliminar el producto: $e';
        });
      }
    }
  }

  @override
  void dispose() {
    // Limpia cualquier recurso o suscripción aquí
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        title: const Text('PETRA',
            style: TextStyle(
              fontFamily: 'TrajanPro',
              fontWeight: FontWeight.bold,
              fontSize: 30,
            )),
      ),
      body: Stack(
        children: [
          Column(
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
                        onPressed: () => deleteFromCart(item.nombreProducto),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 80,
            right: 16,
            child: FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const PedidoScreen()));
              },
              label: const Text('Realizar Pedido', style: TextStyle(color: Colors.white)),
              icon: const Icon(Icons.shopping_cart_checkout, color: Colors.white),
              backgroundColor: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
