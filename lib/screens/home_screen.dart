import 'package:flutter/material.dart';
import 'package:petratest/services/slider.dart';
import 'package:petratest/services/video_controller_provider.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:convert';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controllerProvider = Provider.of<VideoControllerProvider>(context);
    final _controller = controllerProvider.controller;

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
              background: _controller.value.isInitialized
                  ? FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _controller.value.size?.width ?? 0,
                  height: _controller.value.size?.height ?? 0,
                  child: VideoPlayer(_controller),
                ),
              )
                  : Center(child: CircularProgressIndicator()),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 10),
          ),
          SliverToBoxAdapter(
            child: ProductSlider(),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 10),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            sliver: FutureBuilder<List<Map<String, dynamic>>>(
              future: loadProducts(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (snapshot.hasError) {
                  return SliverToBoxAdapter(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  final productList = snapshot.data!;
                  return SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.65,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        return RecentSingleProduct(
                          recentSingleProdName: productList[index]["name"],
                          recentSingleProdImage: productList[index]["img_url"],
                          recentSingleProdPrice: productList[index]["precio"],
                        );
                      },
                      childCount: productList.length,
                    ),
                  );
                }
              },
            ),
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
    return products;
  }
}

class RecentSingleProduct extends StatelessWidget {
  final String? recentSingleProdName;
  final String? recentSingleProdImage;
  final String? recentSingleProdPrice;

  RecentSingleProduct({
    this.recentSingleProdName,
    this.recentSingleProdImage,
    this.recentSingleProdPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 3,
            offset: Offset(0, 2),
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
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) => Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  recentSingleProdName!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  '\$${recentSingleProdPrice}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
