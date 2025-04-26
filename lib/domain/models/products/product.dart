// ignore_for_file: non_constant_identifier_names

import 'package:bossloot_mobile/domain/models/valoration.dart';

class Product {
  int id;
  String name;
  String description;
  String category;
  String brand;
  String model;
  double price;
  double discount;
  int quantity;
  bool on_offer;
  bool featured;
  String image;
  int points;
  List<Valoration> valorations;
  double avg_rating;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.brand,
    required this.model,
    required this.price,
    required this.discount,
    required this.quantity,
    required this.on_offer,
    required this.featured,
    required this.image,
    required this.points,
    required this.valorations,
    required this.avg_rating,
  });
  

}