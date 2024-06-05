class CartItem {
  final String nombreProducto;
  final String color;
  final String talle;
  final double precio;
  int cantidad;

  CartItem({
    required this.nombreProducto,
    required this.color,
    required this.talle,
    required this.precio,
    this.cantidad = 1,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      nombreProducto: json['Nombre_Producto'],
      color: json['Color'],
      talle: json['Talle'],
      precio: json['PRRECIO_IVA_INC'],
      cantidad: json['Cantidad'] ?? 1,
    );
  }

  Map<String, dynamic> toJson() => {
    'Nombre_Producto': nombreProducto,
    'Color': color,
    'Talle': talle,
    'PRRECIO_IVA_INC': precio,
    'Cantidad': cantidad,
  };
}
