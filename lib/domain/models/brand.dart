class Brand {
  final int id;
  final String name;
  final String description;
  final String image;

  Brand({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
  });

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
    };
  }
}