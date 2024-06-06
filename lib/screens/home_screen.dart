import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

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
    return SingleChildScrollView(
      child: Column(
          children: [
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 11.0),
      child: Text(
        'PETRA',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          fontFamily: 'TrajanPro',
        ),
      ),
    ),
      Stack(
        children: [
      Container(
        height: 370,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 11.0),
        child: Image.network(
          "https://f.fcdn.app/imgs/cc5228/petrastore.com.uy/pstouy/1b7f/original/catalogo/JFEL-130_1/460x690/jean-felino-negro.jpg", // Coloca la ruta de tu imagen aquí
          fit: BoxFit.cover,
          width: double.infinity,
        ),
      ),
    ],
    ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Image.network(
                "https://f.fcdn.app/imgs/fcbe9d/petrastore.com.uy/pstouy/c0ed/original/catalogo/COLIV-05Z_1/460x690/camisa-olivia-celeste-cuello-marron.jpg", // Coloca la ruta de tu imagen aquí
                width: 170,
                height: 230,
                fit: BoxFit.cover,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Bucanera Polka - Negro'),
              ),
              const Padding(padding: EdgeInsets.all(8.0)
              child)
            ],
          ),
           Column(
            children: [
              Image.network(
                "https://f.fcdn.app/imgs/f47f55/petrastore.com.uy/pstouy/dd9d/original/catalogo/8568-109_1/460x690/vestido-joaquina-jean.jpg", // Coloca la ruta de tu imagen aquí
                width: 170,
                height: 230,
                fit: BoxFit.cover,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Bota Tartan - Negro'),
              ),
            ],
          ),
      ],
        ),
      ])
     );
  }
}