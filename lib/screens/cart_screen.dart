import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:petratest/screens/Pedido_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String _message = '';
  List<dynamic> _cart = [];
  double _totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    fetchCart();
  }

  void fetchCart() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final path = '${directory.path}/cart.json';
      File file = File(path);

      if (file.existsSync()) {
        String content = await file.readAsString();
        if (content.isNotEmpty) {
          setState(() {
            _cart = jsonDecode(content);
            _calculateTotalPrice();
          });
        }
      } else {
        setState(() {
          _message = 'El carrito está vacío';
        });
      }
    } catch (e) {
      setState(() {
        _message = 'Error al cargar el carrito: $e';
      });
    }
  }

  void _calculateTotalPrice() {
    double total = 0.0;
    for (var item in _cart) {
      total += double.tryParse(item['price'].replaceAll('.', '').replaceAll(',', '.')) ?? 0.0;
    }
    setState(() {
      _totalPrice = total;
    });
  }

  String _getFormattedTotalPrice() {
    String totalPriceString = _totalPrice.toStringAsFixed(2);

    return totalPriceString.length > 5 ? totalPriceString.substring(0, 5) : totalPriceString;
  }

  void deleteFromCart(String nombre) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final path = '${directory.path}/cart.json';
      File file = File(path);

      if (file.existsSync()) {
        String content = await file.readAsString();
        List<dynamic> cart = [];
        if (content.isNotEmpty) {
          cart = jsonDecode(content);
        }

        cart.removeWhere((item) => item['name'] == nombre);

        await file.writeAsString(jsonEncode(cart));

        if (mounted) {
          setState(() {
            _cart = cart;
            _calculateTotalPrice();
            _message = 'Producto eliminado del carrito';
          });
        }
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
              if (_message.isNotEmpty) Text(_message),
              if (_cart.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    itemCount: _cart.length,
                    itemBuilder: (context, index) {
                      var item = _cart[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Image.network(
                                item['img_url'],
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item['name'],
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text('Precio: \$${item['price']}'),
                                    ],
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () => deleteFromCart(item['name']),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
          Positioned(
            bottom: 140,
            right: 16,
            left: 16,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '\$${_getFormattedTotalPrice()}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 80,
            right: 16,
            left: 16,
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
