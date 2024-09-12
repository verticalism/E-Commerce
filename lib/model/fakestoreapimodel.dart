class Item {
  final String imageUrl;
  final String title;
  final String description;
  final double price;
  final double rate;
  final int id;
  final String category;
  final int stock;

  Item({
    required this.imageUrl,
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.rate,
    required this.category,
    required this.stock,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      imageUrl: json['image'],
      title: json['title'],
      description: json['description'],
      price: json['price'].toDouble(),
      category: json['category'],
      rate: json['rating']['rate'].toDouble(),
      stock: json['rating']['count'],
    );
  }
}
