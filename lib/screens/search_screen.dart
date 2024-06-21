import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petratest/screens/product_details.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:convert';

class Searchpage extends StatefulWidget {
  const Searchpage({super.key});

  @override
  _SearchpageState createState() => _SearchpageState();
}

class _SearchpageState extends State<Searchpage> {
  late List<Map<String, dynamic>> _products;
  late List<Map<String, dynamic>> _filteredProducts;

  @override
  void initState() {
    super.initState();
    _filteredProducts = [];
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    final String jsonProducts =
        await DefaultAssetBundle.of(context).loadString('Flask/products.json');
    final List<dynamic> parsedJson = jsonDecode(jsonProducts);
    _products = parsedJson.cast<Map<String, dynamic>>();
    setState(() {
      _filteredProducts = _products;
    });
  }

  void _filterProducts(String query) {
    setState(() {
      _filteredProducts = _products
          .where((product) =>
              product['name'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: CustomScrollView(
          slivers: [
            const SliverAppBar(
              toolbarHeight: 60,
              centerTitle: true,
              title: Text('PETRA',
                  style: TextStyle(
                    fontFamily: 'TrajanPro',
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  )),
              floating: true,
              snap: true,
              elevation: 0,
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Buscar...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: _filterProducts,
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 5),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(bottom: 80),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.65,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return RecentSingleProduct(
                      recentSingleProdName: _filteredProducts[index]["name"],
                      recentSingleProdImage: _filteredProducts[index]
                          ["img_url"],
                      recentSingleProdPrice: _filteredProducts[index]["precio"],
                      index: index,
                    );
                  },
                  childCount: _filteredProducts.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RecentSingleProduct extends StatelessWidget {
  final String? recentSingleProdName;
  final String? recentSingleProdImage;
  final String? recentSingleProdPrice;
  final int index;

  const RecentSingleProduct({super.key, 
    this.recentSingleProdName,
    this.recentSingleProdImage,
    this.recentSingleProdPrice,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(
              title: recentSingleProdName!,
              price: recentSingleProdPrice!,
              imageUrl: recentSingleProdImage!,
              index: index,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: recentSingleProdImage!,
                height: 240,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recentSingleProdName!,
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$$recentSingleProdPrice',
                    style: GoogleFonts.montserrat(
                      fontSize: 17,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
