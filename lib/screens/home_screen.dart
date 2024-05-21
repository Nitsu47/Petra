import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeState();
}
class HomeState extends State<HomeScreen> {


  class Bag {
  String name;
  String imagePath;

  Bag({
    required this.name,
    required this.imagePath,
});
}

  List<Bag> bags = ListOfBags();
  List<String> heroImages = [
    "assets/Images/hero1.png",
    "assets/Images/hero2.png",
  ];

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
                  itemCount: ,
                  options: CarouselOptions(),
                  itemBuilder: (context, index, realIndex) {
                    return Container(
                    color: Colors.red,
                    );
                  })
            ],
          )
        ],
      ),
    );
  }
}