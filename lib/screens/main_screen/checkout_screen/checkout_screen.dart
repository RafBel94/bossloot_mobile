// lib/screens/checkout_screen.dart
// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:bossloot_mobile/domain/models/user.dart';
import 'package:bossloot_mobile/providers/cart/cart_provider.dart';
import 'package:bossloot_mobile/providers/coin_exchange_provider.dart';
import 'package:bossloot_mobile/providers/orders/order_provider.dart';
import 'package:bossloot_mobile/providers/user_provider.dart';
import 'package:bossloot_mobile/screens/main_screen/paypal_screen/paypal_payment_screen.dart';
import 'package:bossloot_mobile/widgets/shared/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final CoinExchangeProvider coinExchangeProvider =Provider.of<CoinExchangeProvider>(context);
    final orderProvider = Provider.of<OrderProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.checkout_screen_title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: [
          // Main content
          SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.checkout_screen_order_summary_label,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                
                // Order items
                if (cartProvider.cart != null)
                  ..._buildOrderItems(cartProvider, coinExchangeProvider),
                
                SizedBox(height: 24),
                
                // Discounts
                if (userProvider.currentUser!.level != 1)
                  ...[
                    Text(
                      AppLocalizations.of(context)!.checkout_screen_discounts_label,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    
                    _buildDiscountSection(userProvider),
                    SizedBox(height: 24),
                  ],

                // Points
                Text(
                  AppLocalizations.of(context)!.checkout_screen_rewards_label,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                
                _buildRewardsSection(cartProvider),
                SizedBox(height: 24),

                // Payment methods
                Text(
                  AppLocalizations.of(context)!.checkout_screen_payment_method_label,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                
                _buildPaymentMethodOption(
                  icon: Icons.paypal,
                  title: 'PayPal',
                  subtitle: 'Pay securely with PayPal',
                  isSelected: true,
                ),

                SizedBox(height: 24),
                
                // Error message
                if (orderProvider.error != null)
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red[50],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.error_outline, color: Colors.red),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            orderProvider.error!,
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ),
                
                SizedBox(height: 40),
              ],
            ),
          ),
          
          // Loading indicator
          if (_isProcessing)
            Container(
              color: Colors.black54,
              child: Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            ),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  List<Widget> _buildOrderItems(CartProvider cartProvider, CoinExchangeProvider coinExchangeProvider) {
    final cart = cartProvider.cart!;
    
    return [
      // Items list
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color.fromRGBO(158, 158, 158, 0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            ...cart.items.map((item) => Container(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey[200]!,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        '${item.quantity}x',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          item.product?.name ?? 'Product',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 12),
                      Text(
                        coinExchangeProvider.formatPrice(coinExchangeProvider.convertPrice(item.totalPrice)),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )),
                
            // Total
            Container(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    coinExchangeProvider.formatPrice(coinExchangeProvider.convertPrice(cart.totalAmount)),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ];
  }

  Widget _buildPaymentMethodOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isSelected,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(158, 158, 158, 0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: isSelected ? Theme.of(context).primaryColor : Colors.transparent,
          width: 2,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              icon,
              size: 32,
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: Theme.of(context).primaryColor,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDiscountSection(UserProvider userProvider) {
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(158, 158, 158, 0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppLocalizations.of(context)!.checkout_screen_level_discount_label,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 105, 26, 158),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: const Color.fromARGB(255, 81, 20, 122),
                width: 1,
              ),
            ),
            child: Text(
              _getUserDiscount(userProvider.currentUser),
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRewardsSection(CartProvider cartProvider) {
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(158, 158, 158, 0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppLocalizations.of(context)!.checkout_screen_points_label,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 105, 26, 158),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: const Color.fromARGB(255, 81, 20, 122),
                width: 1,
              ),
            ),
            child: Text(
              '+ ${(cartProvider.cart!.totalAmount * 0.25).round()} ${AppLocalizations.of(context)!.checkout_screen_points_label}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 35),
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
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: CustomElevatedButton(
            text: 
              AppLocalizations.of(context)!.checkout_screen_button,
            fontSize: 18,
            onPressed: _isProcessing
                ? null
                : () => _proceedToPayment(context),
          )
        ),
      ),
    );
  }

  Future<void> _proceedToPayment(BuildContext context) async {
    setState(() {
      _isProcessing = true;
    });

    try {
      final orderProvider = Provider.of<OrderProvider>(context, listen: false);
      
      final order = await orderProvider.checkout();
      
      if (order != null) {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PayPalPaymentScreen(orderId: order.id),
          ),
        );
        
        if (result == true) {
          Navigator.pushReplacementNamed(
            context, 
            '/order-confirmation',
            arguments: order.id,
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                AppLocalizations.of(context)!.checkout_screen_payment_incomplete,
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  String _getUserDiscount(User? user) {
    switch (user!.level) {
      case 1:
        return 'Level 1:  0%';
      case 2:
        return 'Level 2:  - 5%';
      case 3:
        return 'Level 3:  - 10%';
      case 4:
        return 'Level 4:  - 15%';
      default:
        return 'Level 1:  0%';
    }
  }
}