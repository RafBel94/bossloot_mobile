import 'package:bossloot_mobile/domain/models/user.dart';

class Valoration {
  final int id;
  final int userId;
  final int productId;
  final double rating;
  final String? comment;
  final int likes;
  final int dislikes;
  final User user;
  final DateTime createdAt;
  final DateTime updatedAt;

  Valoration({
    required this.id,
    required this.userId,
    required this.productId,
    required this.rating,
    this.comment,
    required this.likes,
    required this.dislikes,
    required this.user,
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
      likes: json['likes'],
      dislikes: json['dislikes'],
      user: User.fromValorationJson(json['user']),
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
      'likes': likes,
      'dislikes': dislikes,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

}