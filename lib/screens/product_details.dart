import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

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
            height: 497,
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
                  addToCart(context);
                },
                child: const Text('Añadir al carrito'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void addToCart(BuildContext context) async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/cart.json';
    File file = File(path);

    List<dynamic> cart = [];
    if (file.existsSync()) {
      String content = await file.readAsString();
      if (content.isNotEmpty) {
        cart = jsonDecode(content);
      }
    }

    cart.add({
      "name": title,
      "price": price,
      "img_url": imageUrl,
    });

    await file.writeAsString(jsonEncode(cart));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Producto añadido al carrito'),
      ),
    );
  }
}
