// lib/providers/cart_provider.dart
import 'package:bossloot_mobile/domain/models/cart/cart.dart';
import 'package:bossloot_mobile/services/cart/cart_service.dart';
import 'package:flutter/foundation.dart';

class CartProvider extends ChangeNotifier {
  final CartService _cartService;
  Cart? _cart;
  String? _error;

  CartProvider(this._cartService);

  // Getters
  Cart? get cart => _cart;
  String? get error => _error;
  int get itemCount => _cart?.items.length ?? 0;
  double get total => _cart?.totalAmount ?? 0.0;
  
  // Method to load the cart
  Future<void> loadCart() async {
    try {
      _error = null;
      final response = await _cartService.getCart();
      
      if (response.success) {
        _cart = Cart.fromJson(response.data);
      } else {
        _error = response.message;
      }
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  // Method to add a product to the cart
  Future<void> addToCart(int productId, int quantity) async {
    try {
      _error = null;
      final response = await _cartService.addItemToCart(productId, quantity);
      
      if (response.success) {
        _cart = Cart.fromJson(response.data);
      } else {
        _error = response.message;
      }
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  // Method to update the quantity of a product in the cart
  Future<void> updateItemQuantity(int itemId, int quantity) async {
    try {
      _error = null;
      final response = await _cartService.updateCartItem(itemId, quantity);
      
      if (response.success) {
        _cart = Cart.fromJson(response.data);
      } else {
        _error = response.message;
      }
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  // Method to remove a product from the cart
  Future<void> removeItem(int itemId) async {
    try {
      _error = null;
      final response = await _cartService.removeCartItem(itemId);
      
      if (response.success) {
        _cart = Cart.fromJson(response.data);
      } else {
        _error = response.message;
      }
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  // Method to clear the cart
  Future<void> clearCart() async {
    try {
      _error = null;
      final response = await _cartService.clearCart();
      
      if (response.success) {
        _cart = Cart.fromJson(response.data);
      } else {
        _error = response.message;
      }
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  // Method to empty the cart variable, but not the cart in the backend
  void emptyCartVariable() {
    _cart = null;
    notifyListeners();
  }
}