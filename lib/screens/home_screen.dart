import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeState();
}

class Bag {
  String name;
  String imagePath;

  Bag({
    required this.name,
    required this.imagePath,
  });
}

List<Bag> listOfBags() {
  return [
    Bag(name: "top", imagePath: "top.png"),
    Bag(name: "buzz", imagePath: "bag2.png"),
    Bag(name: "pantaloons", imagePath: "bag3.png"),
    Bag(name: "camera", imagePath: "bag4.png"),
  ];
}

class _HomeState extends State<HomeScreen> {
  List<Bag> bags = listOfBags();
  List<String> heroImages = [
    "assets/Icon/top.png",
    "assets/Images/hero2.png",
  ];

  final controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0,
        title: const Text('PETRA',
        style: TextStyle(
          fontFamily: 'TrajanPro',
          fontWeight: FontWeight.bold,
          fontSize: 30,
        )
        ),
            centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Número de columnas
            childAspectRatio: 2 / 3, // Relación de aspecto de los hijos
            crossAxisSpacing: 8.0, // Espaciado entre columnas
            mainAxisSpacing: 8.0, // Espaciado entre filas
          ),
          itemCount: 6, // Número de productos a mostrar
          itemBuilder: (context, index) {
            return ProductCard(
              title: 'Producto ${index + 1}',
              price: '${(index + 1) * 10}.00',
              imageUrl: 'assets/Icon/top.png'
            );
          },
        ),
      ),
    );
  }
}
class ProductCard extends StatelessWidget {
  final String title;
  final String price;
  final String imageUrl;
  const ProductCard({super.key,
    required this.title,
    required this.price,
    required this.imageUrl,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            imageUrl,
            width: double.infinity,
            height: 150,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              '\$$price',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}





