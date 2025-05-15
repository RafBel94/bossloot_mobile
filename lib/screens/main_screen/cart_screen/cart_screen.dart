// lib/screens/cart_screen.dart
// ignore_for_file: library_private_types_in_public_api

import 'package:bossloot_mobile/domain/models/user.dart';
import 'package:bossloot_mobile/providers/cart/cart_provider.dart';
import 'package:bossloot_mobile/providers/coin_exchange_provider.dart';
import 'package:bossloot_mobile/providers/user_provider.dart';
import 'package:bossloot_mobile/screens/main_screen/cart_screen/cart_item_card.dart';
import 'package:bossloot_mobile/screens/main_screen/cart_screen/login_container.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late UserProvider _userProvider;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _userProvider = context.read<UserProvider>();

    if(_userProvider.currentUser != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _loadCart();
      });
    }
  }

  Future<void> _loadCart() async {
    setState(() {
      _isLoading = true;
    });
    
    await Provider.of<CartProvider>(context, listen: false).loadCart();
    
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.read<UserProvider>();
    User? user = userProvider.currentUser;
    
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 248, 248),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : user == null 
            ? LoginContainer(context: context,)
            : _buildCartContent(),
      bottomNavigationBar: user == null ? null : _buildBottomBar(),
    );
  }

  Widget _buildCartContent() {
    final cartProvider = Provider.of<CartProvider>(context, listen: true);
    
    if (cartProvider.error != null) {
      return Center(
        child: Text(
          'Error: ${cartProvider.error}',
          style: TextStyle(color: Colors.red),
        ),
      );
    }
    
    // If the cart is null or empty, show an empty cart message
    if (cartProvider.cart == null || (cartProvider.itemCount == 0 && cartProvider.total <= 0)) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              size: 80,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              'Your cart is empty',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Add some products to your cart and they will appear here',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600]),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              child: Text('Browse Products'),
              onPressed: () {
                Navigator.of(context).pushNamed('/products');
              },
            ),
          ],
        ),
      );
    }
    
    // If the cart is not empty, show the cart items
    return RefreshIndicator(
      onRefresh: _loadCart,
      child: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: cartProvider.itemCount,
        itemBuilder: (ctx, i) {
          final item = cartProvider.cart!.items[i];
          return CartItemCard(
            item: item,
            onQuantityChanged: (quantity) {
              setState(() {
                _isLoading = true;
              });
              cartProvider.updateItemQuantity(item.id, quantity).then((_) {
                setState(() {
                  _isLoading = false;
                });
              });
            },
            onRemove: () {
              setState(() {
                _isLoading = true;
              });
              cartProvider.removeItem(item.id).then((_) {
                setState(() {
                  _isLoading = false;
                });
              });
            },
          );
        },
      ),
    );
  }

  Widget _buildBottomBar() {
    final cartProvider = Provider.of<CartProvider>(context);
    final coinExchangeProvider = Provider.of<CoinExchangeProvider>(context);

    double totalWithoutDiscount;
    bool hasDiscount = false;
    
    if (cartProvider.cart == null || cartProvider.itemCount == 0) {
      return SizedBox.shrink();
    } else {
      totalWithoutDiscount = cartProvider.cart!.items.fold(0.0, (sum, item){
        return sum + (coinExchangeProvider.convertPrice(item.product?.price ?? 0)) * item.quantity;
      });

      // Check if any item in the cart has a discount
      hasDiscount = cartProvider.cart?.items
        .any((item) {
          final discount = item.product?.discount;
          return discount != null && discount > 0;
        }) ?? false;
    }


    
    
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(158, 158, 158, 0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // Display the total price with discount if applicable
                Row(
                  children: [
                    if (hasDiscount)
                    Text(
                      coinExchangeProvider.formatPrice(totalWithoutDiscount),
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),

                    SizedBox(width: 8),

                    Text(
                      coinExchangeProvider.formatPrice(coinExchangeProvider.convertPrice(cartProvider.total)),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: const Color.fromARGB(255, 255, 231, 249),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: BorderSide(
                      color: const Color.fromARGB(152, 126, 16, 189),
                      width: 2,
                    ),
                  ),
                ),
                child: Text(
                  AppLocalizations.of(context)!.cart_screen_checkout_button,
                  style: GoogleFonts.orbitron(fontSize: 16, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed('/checkout');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
