import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

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
    Bag(name: "top", imagePath: "bag1.png"),
    Bag(name: "buzz", imagePath: "bag2.png"),
    Bag(name: "pantaloons", imagePath: "bag3.png"),
    Bag(name: "camera", imagePath: "bag4.png"),
  ];
}

class _HomeState extends State<HomeScreen> {
  List<Bag> bags = listOfBags();
  List<String> heroImages = [
    "assets/Images/hero1.png",
    "assets/Images/hero2.png",
  ];

  final controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 90,
        elevation: 0,
        title: Text('Petra',
            style: GoogleFonts.playfairDisplay(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        leading: IconButton(
            iconSize: 48,
            onPressed: () {},
            icon: SvgPicture.asset("assets/Icon/burger")),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
                color: Colors.black, shape: BoxShape.circle),
            child: Image.asset('', fit: BoxFit.contain),
          )
        ],
      ),
      body: Column(
        children: [

          Stack(
            children: [
              CarouselSlider.builder(
                  itemCount: heroImages.length,
                  options: CarouselOptions(viewportFraction: 1, height: 205),
                  itemBuilder: (context, index, realIndex) {
                    return Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(heroImages[index]),
                              fit: BoxFit.cover)),
                      child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 12),
                              )
                            ]),
                      );
                    }),
              Positioned(
                bottom: 1,
                right: 22,
                child: Row(
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            minimumSize: const Size(50, 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0))),
                        onPressed: previousPage,
                        child: const Icon(
                          Icons.arrow_back,
                          size: 30,
                        )),
                    const SizedBox(width: 3),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        minimumSize: const Size(50, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0))),
                    onPressed: nextPage,
                    child: const Icon(
                      Icons.arrow_forward,
                      size: 30,
                    ))
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }


  void previousPage() {
    controller.previousPage(duration: const Duration(milliseconds: 2000));
  }

  void nextPage() {
    controller.nextPage(duration: const Duration(milliseconds: 2000));
  }
 }
