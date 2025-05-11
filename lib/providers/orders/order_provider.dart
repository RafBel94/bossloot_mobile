// lib/providers/order_provider.dart
import 'package:bossloot_mobile/domain/models/orders/order.dart';
import 'package:bossloot_mobile/services/orders/order_service.dart';
import 'package:flutter/foundation.dart';

class OrderProvider extends ChangeNotifier {
  final OrderService _orderService;
  List<Order> _orders = [];
  Order? _currentOrder;
  String? _error;

  OrderProvider(this._orderService);

  // Getters
  List<Order> get orders => _orders;
  Order? get currentOrder => _currentOrder;
  String? get error => _error;

  // Method to load all orders
  Future<void> loadOrders() async {
    try {
      _error = null;
      final response = await _orderService.getOrders();
      
      if (response.success) {
        _orders = (response.data as List).map((data) => Order.fromJson(data)).toList();
      } else {
        _error = response.message;
      }
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  // Method to load a specific order
  Future<void> loadOrder(int orderId) async {
    try {
      _error = null;
      final response = await _orderService.getOrder(orderId);
      
      if (response.success) {
        _currentOrder = Order.fromJson(response.data);
      } else {
        _error = response.message;
      }
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  // Method to create an order (checkout)
  Future<Order?> checkout() async {
    try {
      _error = null;
      final response = await _orderService.checkout();
      
      if (response.success) {
        final order = Order.fromJson(response.data['order']);
        _currentOrder = order;
        _orders.insert(0, order); // Add the new order to the beginning of the list
        notifyListeners();
        return order;
      } else {
        _error = response.message;
        notifyListeners();
        return null;
      }
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return null;
    }
  }

  // Method to update an existing order (useful after payment)
  void updateOrder(Order order) {
    try {
      final index = _orders.indexWhere((o) => o.id == order.id);
      if (index >= 0) {
        _orders[index] = order;
        
        if (_currentOrder?.id == order.id) {
          _currentOrder = order;
        }
        
        notifyListeners();
      }
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
}