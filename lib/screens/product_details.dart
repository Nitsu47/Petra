import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/api_service.dart';

class ProductDetailScreen extends StatelessWidget {
  final String title;
  final String price;
  final String imageUrl;
  final int index;

  const ProductDetailScreen({
    super.key,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.index,
  });

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
            height: 550,
            fit: BoxFit.cover,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                title,
                style: GoogleFonts.montserrat(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                '\$$price',
                style: GoogleFonts.montserrat(
                  fontSize: 25,
                  color: Colors.grey[700],
                ),
              ),
            ),
          ),
          const SizedBox(height: 60),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 4,
                  minimumSize: const Size(400, 60),
                ),
                onPressed: () {
                  final scaffoldContext = context;
                  addToCart(scaffoldContext);
                },
                child: const Text('Añadir al carrito'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void addToCart(BuildContext context) {
    final apiService = ApiService();
    apiService.addToCart(index)
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