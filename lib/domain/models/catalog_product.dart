class CatalogProduct {
  final int id;
  final String name;
  final String description;
  final String model;
  final double price;
  final int quantity;
  final bool onOffer;
  final double discount;
  final bool featured;
  final String image;
  final int points;
  final String category;
  final String brand;

  CatalogProduct(
    this.id,
    this.name,
    this.description,
    this.model,
    this.price,
    this.quantity,
    this.onOffer,
    this.discount,
    this.featured,
    this.image,
    this.points,
    this.category,
    this.brand
  );

  factory CatalogProduct.fromJson(Map<String, dynamic> json) {
    return CatalogProduct(
      json['id'],
      json['name'],
      json['description'],
      json['model'],
      double.parse(json['price'].toString()),
      json['quantity'],
      json['on_offer'] == 1,
      double.parse(json['discount'].toString()),
      json['featured'] == 1,
      json['image'],
      json['points'],
      json['category'],
      json['brand']
    );
  }
}