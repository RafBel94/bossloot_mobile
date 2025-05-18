// lib/models/paypal_response.dart
class PaypalResponse {
  final bool success;
  final String message;
  final dynamic data; // Usamos dynamic para aceptar tanto Map como List

  PaypalResponse({
    required this.success, 
    required this.message, 
    required this.data
  });

  factory PaypalResponse.fromJson(Map<String, dynamic> json) {
    return PaypalResponse(
      success: json['success'],
      message: json['message'],
      data: json['data'] ?? {'error': 'Empty data'},
    );
  }

  // Método para obtener la URL de aprobación
  String? getApprovalUrl() {
    if (data is Map) {
      final links = (data as Map)['links'];
      if (links is List) {
        final approveLink = links.firstWhere(
          (link) => link['rel'] == 'approve',
          orElse: () => {'href': ''},
        );
        return approveLink['href'];
      }
    } else if (data is List && data.isNotEmpty) {
      // Si data es una lista, busca enlaces en el primer elemento
      final firstItem = data[0];
      if (firstItem is Map && firstItem.containsKey('links')) {
        final links = firstItem['links'];
        if (links is List) {
          final approveLink = links.firstWhere(
            (link) => link['rel'] == 'approve',
            orElse: () => {'href': ''},
          );
          return approveLink['href'];
        }
      }
    }
    return null;
  }

  // Método para obtener el ID de la orden PayPal
  String? getOrderId() {
    if (data is Map) {
      return data['id'];
    } else if (data is List && data.isNotEmpty) {
      return data[0]['id'];
    }
    return null;
  }
}