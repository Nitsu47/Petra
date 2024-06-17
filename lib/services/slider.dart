import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ProductSlider extends StatefulWidget {
  const ProductSlider({super.key});

  @override
  State<ProductSlider> createState() => _ProductSliderState();
}

class _ProductSliderState extends State<ProductSlider> {
  final List<String> imgList = [
    'https://f.fcdn.app/imgs/ffec5f/petrastore.com.uy/pstouy/88fa/original/catalogo/lc2232-022_1/460x690/campera-akita-beige.jpg',
    'https://f.fcdn.app/imgs/8b9e0a/petrastore.com.uy/pstouy/0603/webp/recursos/70/0x0/640-x-600-coleccion.jpg', // Replace with your image URLs or asset paths
    'https://f.fcdn.app/imgs/8bd80b/petrastore.com.uy/pstouy/de53/webp/recursos/74/0x0/640-x-640-complementos.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: imgList.map((item) {
        return Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10)
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              item,
              fit: BoxFit.cover,
            ),
          ),
        );
      }).toList(),
      options: CarouselOptions(
        height: 400,
        autoPlay: true,
        enlargeCenterPage: true,
        autoPlayInterval: const Duration(seconds: 2),
        aspectRatio: 16/9,
        viewportFraction: 1,
      ),
    );
  }
}