// ignore_for_file: non_constant_identifier_names

import 'package:bossloot_mobile/domain/models/products/product.dart';
import 'package:bossloot_mobile/domain/models/valoration.dart';

class DisplayProduct extends Product{
  String resolution;
  int refresh_rate;
  int response_time;
  String panel_type;
  String aspect_ratio;
  bool curved;
  int brightness;
  String contrast_ratio;
  String sync_type;
  int hdmi_ports;
  int display_ports;
  int inches;
  double weight;

  DisplayProduct({
    required super.id,
    required super.name,
    required super.description,
    required super.category,
    required super.brand,
    required super.model,
    required super.price,
    required super.discount,
    required super.quantity,
    required super.on_offer,
    required super.featured,
    required super.image,
    required super.points,
    required super.deleted,
    required super.valorations,
    required super.avg_rating,
    required this.resolution,
    required this.refresh_rate,
    required this.response_time,
    required this.panel_type,
    required this.aspect_ratio,
    required this.curved,
    required this.brightness,
    required this.contrast_ratio,
    required this.sync_type,
    required this.hdmi_ports,
    required this.display_ports,
    required this.inches,
    required this.weight
  });

  factory DisplayProduct.fromJson(Map<String, dynamic> json) {
    return DisplayProduct(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      category: json['category'],
      brand: json['brand'],
      model: json['model'],
      price: double.parse(json['price'].toString()),
      discount: double.parse(json['discount'].toString()),
      quantity: json['quantity'],
      on_offer: json['on_offer'] == 1,
      featured: json['featured'] == 1,
      image: json['image'],
      points: json['points'],
      deleted: json['deleted'] == 1 || json['deleted'] == true,
      valorations: (json['valorations'] as List)
          .map((valoration) => Valoration.fromJson(valoration))
          .toList(),
      avg_rating: double.parse(json['avg_rating'].toString()),
      resolution: json['specs']['resolution'],
      refresh_rate: json['specs']['refresh_rate'],
      response_time: json['specs']['response_time'],
      panel_type: json['specs']['panel_type'],
      aspect_ratio: json['specs']['aspect_ratio'],
      curved: json['specs']['curved'] == 1,
      brightness: json['specs']['brightness'],
      contrast_ratio: json['specs']['contrast_ratio'],
      sync_type: json['specs']['sync_type'],
      hdmi_ports: json['specs']['hdmi_ports'],
      display_ports: json['specs']['display_ports'],
      inches: json['specs']['inches'],
      weight: double.parse(json['specs']['weight'].toString())
    );
  }
}