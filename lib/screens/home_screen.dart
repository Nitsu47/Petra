import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petratest/services/slider.dart';
import 'package:petratest/services/video_controller_provider.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'product_details.dart';
import 'dart:convert';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controllerProvider = Provider.of<VideoControllerProvider>(context);
    final controller = controllerProvider.controller;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            pinned: true,
            expandedHeight: 600,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'PETRA',
                style: TextStyle(
                  fontFamily: 'TrajanPro',
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.white38,
                ),
              ),
              centerTitle: true,
              background: controller != null && controller.value.isInitialized
                  ? FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: controller.value.size.width,
                  height: controller.value.size.height,
                  child: VideoPlayer(controller),
                ),
              )
                  : const Center(child: CircularProgressIndicator()),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 10),
          ),
          const SliverToBoxAdapter(
            child: ProductSlider(),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 5),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Te puede interesar...',
                style: GoogleFonts.montserrat(
                    fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 5),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            sliver: FutureBuilder<List<Map<String, dynamic>>>(
              future: loadProducts(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (snapshot.hasError) {
                  return SliverToBoxAdapter(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return const SliverToBoxAdapter(
                    child: Text('No products found'),
                  );
                } else {
                  final productList = snapshot.data!;
                  return SliverGrid(
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.65,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        final product = productList[index];
                        return RecentSingleProduct(
                          recentSingleProdName: product["name"],
                          recentSingleProdImage: product["img_url"],
                          recentSingleProdPrice: product["precio"],
                          index: index,
                        );
                      },
                      childCount: productList.length,
                    ),
                  );
                }
              },
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 85),
          ),
        ],
      ),
    );
  }

  Future<List<Map<String, dynamic>>> loadProducts(BuildContext context) async {
    final String jsonProducts =
    await DefaultAssetBundle.of(context).loadString('Flask/products.json');
    final List<dynamic> parsedJson = jsonDecode(jsonProducts);
    final List<Map<String, dynamic>> products =
    parsedJson.cast<Map<String, dynamic>>();

    products.shuffle();
    return products.take(6).toList();
  }
}

class RecentSingleProduct extends StatelessWidget {
  final String recentSingleProdName;
  final String recentSingleProdImage;
  final String recentSingleProdPrice;
  final int index;

  const RecentSingleProduct({
    super.key,
    required this.recentSingleProdName,
    required this.recentSingleProdImage,
    required this.recentSingleProdPrice,
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
              title: recentSingleProdName,
              price: recentSingleProdPrice,
              imageUrl: recentSingleProdImage,
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
              child: recentSingleProdImage.isNotEmpty
                  ? CachedNetworkImage(
                imageUrl: recentSingleProdImage,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              )
                  : const Icon(Icons.error),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recentSingleProdName,
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
