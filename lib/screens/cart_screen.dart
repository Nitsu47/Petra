import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/models/product.dart';
import '/screens/cart.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrito de Compras'),
      ),
      body: Consumer<ShoppingCart>(
        builder: (context, cart, child) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cart.productNumber,
                  itemBuilder: (context, index) {
                    var product = cart.items.values.toList()[index];
                    return ListTile(
                      title: Text(product.title),
                      subtitle: Text('${product.price} x ${product.quantity}'),
                      trailing: IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          cart.removeProduct(product.id);
                        },
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Precio inicial: ${cart.initialPrice.toStringAsFixed(2)}'),
                    Text('Impuestos: ${cart.taxes.toStringAsFixed(2)}'),
                    Text('Precio total: ${cart.totalPrice.toStringAsFixed(2)}'),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  cart.clearCart();
                },
                child: Text('Limpiar Carrito'),
              ),
            ],
          );
        },
      ),
    );
  }
}
