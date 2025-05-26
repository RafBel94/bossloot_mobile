// ignore_for_file: non_constant_identifier_names

import 'package:bossloot_mobile/domain/models/products/product.dart';
import 'package:bossloot_mobile/domain/models/valoration.dart';

class MotherboardProduct extends Product {
  final String socket;
  final String chipset;
  final String form_factor;
  final int memory_max;
  final int memory_slots;
  final String memory_type;
  final int memory_speed;
  final int sata_ports;
  final int m_2_slots;
  final int pcie_slots;
  final int usb_ports;
  final String lan;
  final String audio;
  final bool wifi;
  final bool bluetooth;

  MotherboardProduct({
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
    required this.socket,
    required this.chipset,
    required this.form_factor,
    required this.memory_max,
    required this.memory_slots,
    required this.memory_type,
    required this.memory_speed,
    required this.sata_ports,
    required this.m_2_slots,
    required this.pcie_slots,
    required this.usb_ports,
    required this.lan,
    required this.audio,
    required this.wifi,
    required this.bluetooth,
  });

  factory MotherboardProduct.fromJson(Map<String, dynamic> json) {
    return MotherboardProduct(
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
      socket: json['specs']['socket'],
      chipset: json['specs']['chipset'],
      form_factor: json['specs']['form_factor'],
      memory_max: json['specs']['memory_max'],
      memory_slots: json['specs']['memory_slots'],
      memory_type: json['specs']['memory_type'],
      memory_speed: json['specs']['memory_speed'],
      sata_ports: json['specs']['sata_ports'],
      m_2_slots: json['specs']['m_2_slots'],
      pcie_slots: json['specs']['pcie_slots'],
      usb_ports: json['specs']['usb_ports'],
      lan: json['specs']['lan'],
      audio: json['specs']['audio'],
      wifi: json['specs']['wifi'] == 1,
      bluetooth: json['specs']['bluetooth'] == 1,
    );
  }
}