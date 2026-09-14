class Product {
  int id;
  String title;
  String description;
  double price;
  double rating;
  String thumbnail;
  List<String> images;

  Product(
    this.id,
    this.title,
    this.description,
    this.price,
    this.rating,
    this.thumbnail,
    this.images,
  );

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      json['id'],
      json['title'],
      json['description'],
      json['price'].toDouble(),
      json['rating'].toDouble(),
      json['thumbnail'],
      List<String>.from(json['images']),
    );
  }
}