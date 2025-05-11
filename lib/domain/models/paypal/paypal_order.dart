
import 'dart:convert';
import 'package:flutter/foundation.dart';

class PayPalOrder {
  final String id;
  final String status;
  final List<PayPalLink> links;

  PayPalOrder({
    required this.id,
    required this.status,
    required this.links,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'status': status,
      'links': links.map((x) => x.toMap()).toList(),
    };
  }

  factory PayPalOrder.fromJson(Map<String, dynamic> map) {
    return PayPalOrder(
      id: map['id'] ?? '',
      status: map['status'] ?? '',
      links: List<PayPalLink>.from(map['links']?.map((x) => PayPalLink.fromJson(x)) ?? []),
    );
  }

  String toJson() => json.encode(toMap());

  factory PayPalOrder.fromJsonString(String source) => PayPalOrder.fromJson(json.decode(source));

  String? getApprovalUrl() {
    final approveLink = links.firstWhere(
      (link) => link.rel == 'approve',
      orElse: () => PayPalLink(href: '', rel: '', method: ''),
    );
    return approveLink.href.isNotEmpty ? approveLink.href : null;
  }

  @override
  String toString() => 'PayPalOrder(id: $id, status: $status, links: $links)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is PayPalOrder &&
      other.id == id &&
      other.status == status &&
      listEquals(other.links, links);
  }

  @override
  int get hashCode => id.hashCode ^ status.hashCode ^ links.hashCode;
}

class PayPalLink {
  final String href;
  final String rel;
  final String method;

  PayPalLink({
    required this.href,
    required this.rel,
    required this.method,
  });

  Map<String, dynamic> toMap() {
    return {
      'href': href,
      'rel': rel,
      'method': method,
    };
  }

  factory PayPalLink.fromJson(Map<String, dynamic> map) {
    return PayPalLink(
      href: map['href'] ?? '',
      rel: map['rel'] ?? '',
      method: map['method'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PayPalLink.fromJsonString(String source) => PayPalLink.fromJson(json.decode(source));

  @override
  String toString() => 'PayPalLink(href: $href, rel: $rel, method: $method)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is PayPalLink &&
      other.href == href &&
      other.rel == rel &&
      other.method == method;
  }

  @override
  int get hashCode => href.hashCode ^ rel.hashCode ^ method.hashCode;
}