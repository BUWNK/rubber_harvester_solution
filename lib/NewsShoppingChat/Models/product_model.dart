// title, image, price, description

class ProductModel {
  final String id;
  final String title;
  final String image;
  final double price;
  final String description;

  ProductModel({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
    required this.description,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'],
      title: map['title'],
      image: map['image'],
      price: map['price']?.toDouble() ?? 0.0,
      description: map['description'],
    );
  }
}
