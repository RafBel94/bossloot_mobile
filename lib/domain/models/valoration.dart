import 'package:bossloot_mobile/domain/models/user.dart';

class Valoration {
  final int id;
  final int userId;
  final int productId;
  final double rating;
  final String? comment;
  final bool verified;
  final User user;
  final String? image;
  final DateTime createdAt;
  final DateTime updatedAt;

  Valoration({
    required this.id,
    required this.userId,
    required this.productId,
    required this.rating,
    this.comment,
    this.verified = false,
    required this.user,
    this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Valoration.fromJson(Map<String, dynamic> json) {
    return Valoration(
      id: json['id'],
      userId: json['user_id'],
      productId: json['product_id'],
      rating: double.parse(json['rating'].toString()),
      comment: json['comment'],
      verified: json['verified'] == 1,
      user: User.fromValorationJson(json['user']),
      image: json['image'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'product_id': productId,
      'rating': rating,
      'comment': comment,
      'verified': verified ? 1 : 0,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

}