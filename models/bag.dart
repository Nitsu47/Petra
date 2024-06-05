

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