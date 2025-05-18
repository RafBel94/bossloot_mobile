// lib/screens/cart_screen.dart
// ignore_for_file: library_private_types_in_public_api

import 'package:bossloot_mobile/domain/models/user.dart';
import 'package:bossloot_mobile/providers/cart/cart_provider.dart';
import 'package:bossloot_mobile/providers/coin_exchange_provider.dart';
import 'package:bossloot_mobile/providers/user_provider.dart';
import 'package:bossloot_mobile/screens/main_screen/cart_screen/cart_item_card.dart';
import 'package:bossloot_mobile/screens/main_screen/cart_screen/empty_cart_container.dart';
import 'package:bossloot_mobile/screens/main_screen/cart_screen/login_container.dart';
import 'package:bossloot_mobile/utils/dialog_util.dart';
import 'package:bossloot_mobile/widgets/shared/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background-image-goblin-shop-2.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : user == null 
              ? LoginContainer(context: context,)
              : _buildCartContent(),
      ),
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
      return EmptyCartContainer(context: context);
    }
    
    // If the cart is not empty, show the cart items
    return RefreshIndicator(
      onRefresh: _loadCart,
      child: ListView.builder(
        padding: EdgeInsets.all(8),
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
              DialogUtil.showRemoveFromCartDialog(context, cartProvider, item);
              setState(() {
                _isLoading = false;
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
    final userProvider = Provider.of<UserProvider>(context);

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Special discount
            if (userProvider.currentUser?.level != 1)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.cart_screen_special_discount_label,
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(255, 134, 134, 134),
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

            if (userProvider.currentUser?.level != 1)
            Divider(
              color: Colors.grey,
              thickness: 1,
              height: 20,
            ),

            // Total and price
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
                    if (hasDiscount || userProvider.currentUser?.level != 1)
                    Text(
                      coinExchangeProvider.formatPrice(totalWithoutDiscount),
                      style: TextStyle(
                        fontSize: 18,
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
              child: CustomElevatedButton(
                text: AppLocalizations.of(context)!.cart_screen_checkout_button,
                fontSize: 20,
                onPressed: () {
                  Navigator.pushNamed(context, '/checkout');
                },
              )
            ),
          ],
        ),
      ),
    );
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
