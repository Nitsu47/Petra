import 'package:flutter/material.dart';
import '/screens/cart_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CartWidget extends StatefulWidget {
  const CartWidget({super.key});
  @override
  CartWidgetState createState() => CartWidgetState();
}

class CartWidgetState extends State<CartWidget> {
  String _message = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrito de Compras'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              addToCart();
            },
            child: const Text('Agregar al Carrito'),
          ),
          ElevatedButton(
            onPressed: () {
              deleteFromCart();
            },
            child: const Text('Eliminar del Carrito'),
          ),
           CartScreen(),
        ],
      ),
    );
  }

  Future<void> addToCart() async {
    final addCart = await http.get(Uri.parse(
        'http://2800:a4:1eb5:800:40e2:227c:31ce:de4e:5000/a%C3%B1adir_al_carrito'));
    if (addCart.statusCode == 200) {
      setState(() {
        _message = json.decode(addCart.body)['item added to cart'];
      });
    } else {
      setState(() {
        _message = 'Failed to load data';
      });
    }
  }

  Future<void> deleteFromCart() async {
    final delFromCart = await http.get(Uri.parse(
        'http://2800:a4:1eb5:800:40e2:227c:31ce:de4e:5000/eliminar_producto?Nombre_Producto=Top%20Volare&Color=Negro%20lurex&Talle=Talle%20Unico'));
    if (delFromCart.statusCode == 200) {
      setState(() {
        _message = json.decode(delFromCart.body)['item deleted'];
      });
    } else {
      setState(() {
        _message = 'failed to delete item';
      });
    }
  }
}
