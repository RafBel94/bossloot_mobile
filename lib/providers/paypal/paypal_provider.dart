// lib/providers/paypal_provider.dart
import 'package:bossloot_mobile/domain/models/orders/order.dart';
import 'package:bossloot_mobile/providers/orders/order_provider.dart';
import 'package:bossloot_mobile/services/paypal/paypal_service.dart';
import 'package:flutter/foundation.dart';
import 'package:bossloot_mobile/domain/models/paypal_response.dart';

class PayPalProvider extends ChangeNotifier {
  final PayPalService _paypalService;
  OrderProvider _orderProvider;
  PaypalResponse? _paypalResponse;
  String? _error;
  bool _paymentSuccess = false;

  PayPalProvider(this._paypalService, this._orderProvider);

  // Getters
  PaypalResponse? get paypalResponse => _paypalResponse;
  String? get error => _error;
  bool get paymentSuccess => _paymentSuccess;
  String? get approvalUrl => _paypalResponse?.getApprovalUrl();
  
  // Method to create a PayPal order
  Future<bool> createPayPalOrder(int orderId) async {
  try {
    _error = null;
    _paymentSuccess = false;
    _paypalResponse = null;
    
    final response = await _paypalService.createPayPalOrder(orderId);
    _paypalResponse = response;
    
    if (response.success) {
      final url = response.getApprovalUrl();
      if (url == null || url.isEmpty) {
        _error = 'No approval URL found in the PayPal response';
        notifyListeners();
        return false;
      }
      
      notifyListeners();
      return true;
    } else {
      _error = response.message;
      notifyListeners();
      return false;
    }
  } catch (e) {
    _error = e.toString();
    notifyListeners();
    return false;
  }
}

  // Method to capture/confirm a PayPal payment
  Future<bool> capturePayment(String paypalOrderId) async {
    try {
      _error = null;
      
      final response = await _paypalService.capturePayment(paypalOrderId);
      
      if (response.success) {
        _paymentSuccess = true;
        
        // Update the order in the OrderProvider
        if (response.data is Map && response.data.containsKey('order')) {
          _orderProvider.updateOrder(Order.fromJson(response.data['order']));
        }
        
        notifyListeners();
        return true;
      } else {
        _error = response.message;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  // Method to reset the state (useful when starting a new payment process)
  void reset() {
    try {
      _paypalResponse = null;
      _error = null;
      _paymentSuccess = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  // Method to update the OrderProvider reference (for ChangeNotifierProxyProvider)
  void updateOrderProvider(OrderProvider orderProvider) {
    _orderProvider = orderProvider;
  }
}