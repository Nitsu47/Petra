class CartItem {
  final String nombreProducto;
  final String color;
  final String talle;
  final double precio;
  final String imageUrl;
  int cantidad;

  CartItem({
    required this.nombreProducto,
    required this.color,
    required this.talle,
    required this.precio,
    required this.imageUrl,
    this.cantidad = 1,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      nombreProducto: json['Nombre_Producto'],
      color: json['Color'],
      talle: json['Talle'],
      precio: json['PRRECIO_IVA_INC'],
      imageUrl: json['ImageUrl'],
      cantidad: json['Cantidad'] ?? 1,
    );
  }

  Map<String, dynamic> toJson() => {
    'Nombre_Producto': nombreProducto,
    'Color': color,
    'Talle': talle,
    'PRRECIO_IVA_INC': precio,
    'ImageUrl': imageUrl,
    'Cantidad': cantidad,
  };
}

List<CartItem> cartItems = [];

void addToCart(String title, String price, String imageUrl) {
  final newItem = CartItem(
    nombreProducto: title,
    color: '',
    talle: '',
    precio: double.parse(price),
    imageUrl: imageUrl,
    cantidad: 1,
  );

  cartItems.add(newItem);
}
