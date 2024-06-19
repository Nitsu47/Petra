class CartItem {
  final String nombreProducto;
  final double precio;
  final String imageUrl;
  int cantidad;

  CartItem({
    required this.nombreProducto,
    required this.precio,
    required this.imageUrl,
    this.cantidad = 1,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      nombreProducto: json['name'],
      precio: double.parse(json['precio']),
      imageUrl: json['img_url'],
      cantidad: json['cantidad'] ?? 1,
    );
  }

  Map<String, dynamic> toJson() => {
    'name': nombreProducto,
    'precio': precio.toString(),
    'img_url': imageUrl,
    'cantidad': cantidad,
  };
}
