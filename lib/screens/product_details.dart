import 'package:flutter/material.dart';
import '../services/api_service.dart';

class ProductDetailScreen extends StatelessWidget {
  final String title;
  final String price;
  final String imageUrl;

  const ProductDetailScreen({
    Key? key,
    required this.title,
    required this.price,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            imageUrl,
            width: double.infinity,
            height: 250,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              '\$$price',
              style: const TextStyle(fontSize: 20, color: Colors.grey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                final scaffoldContext = context;
                addToCart(scaffoldContext);
              },
              child: const Text('Añadir al carrito'),
            ),
          ),
        ],
      ),
    );
  }

  void addToCart(BuildContext context) {
    final apiService = ApiService();
    apiService.addToCart(/*unfinished*/)
      .then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Producto añadido al carrito'),
          ),
        );
      })
      .catchError((e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
          ),
        );
      });
  }
}
