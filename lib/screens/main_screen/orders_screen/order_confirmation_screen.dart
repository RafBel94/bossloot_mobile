// lib/screens/order_confirmation_screen.dart
// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, avoid_print

import 'package:bossloot_mobile/providers/coin_exchange_provider.dart';
import 'package:bossloot_mobile/providers/orders/order_provider.dart';
import 'package:bossloot_mobile/screens/main_screen/main_screen.dart';
import 'package:bossloot_mobile/screens/main_screen/orders_screen/orders_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrderConfirmationScreen extends StatefulWidget {
  const OrderConfirmationScreen({super.key});

  @override
  _OrderConfirmationScreenState createState() => _OrderConfirmationScreenState();
}

class _OrderConfirmationScreenState extends State<OrderConfirmationScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    
    Future.microtask(() {
      final orderId = ModalRoute.of(context)!.settings.arguments as int;
      _loadOrder(orderId);
    });
  }

  Future<void> _loadOrder(int orderId) async {
    if (!mounted) return;
    
    setState(() {
      _isLoading = true;
    });
    
    try {
      await Provider.of<OrderProvider>(context, listen: false).loadOrder(orderId);
    } catch (e) {
      print('ERROR in OrderConfirmationScreen._loadOrder: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    final order = orderProvider.currentOrder;
    final theme = Theme.of(context);
    
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => OrdersScreen(),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF9F9F9),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: theme.primaryColor,
          title: Text(
            AppLocalizations.of(context)!.orders_details_screen_title,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pushReplacement(context, 
                MaterialPageRoute(
                  builder: (context) => OrdersScreen(),
                ),
              );
            },
          ),
        ),
        body: _isLoading
            ? _buildLoadingState(theme)
            : _buildConfirmationContent(context, orderProvider, order),
      ),
    );
  }

  Widget _buildLoadingState(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 60,
            height: 60,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(theme.primaryColor),
              strokeWidth: 3,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            AppLocalizations.of(context)!.orders_details_loading_text,
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmationContent(BuildContext context, OrderProvider orderProvider, order) {
    final theme = Theme.of(context);
    final coinExchangeProvider = context.read<CoinExchangeProvider>();
    
    if (orderProvider.error != null) {
      return _buildErrorState(context, orderProvider.error!, theme);
    }

    if (order == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 20),
            Text(
              AppLocalizations.of(context)!.orders_details_not_found_label,
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              AppLocalizations.of(context)!.orders_details_not_found_text,
              style: GoogleFonts.poppins(
                color: Colors.grey[600],
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              icon: const Icon(Icons.list_alt),
              label: Text(AppLocalizations.of(context)!.orders_details_view_all_orders_button),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                textStyle: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/orders');
              },
            ),
          ],
        ),
      );
    }

    // Determinar el color de estado según el status
    final statusConfig = _getStatusConfig(order.status);

    return SingleChildScrollView(
      child: Column(
        children: [
          // Header with status bar
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: theme.primaryColor,
            ),
            child: Column(
              children: [
                // Order Status Indicator
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(255, 255, 255, 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          statusConfig['icon'],
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        statusConfig['label'],
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${AppLocalizations.of(context)!.orders_card_reference_id} #${order.id}',
                        style: GoogleFonts.poppins(
                          color: const Color.fromRGBO(255, 255, 255, 0.2),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Order Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Order Details Card
                _buildCardSection(
                  title: AppLocalizations.of(context)!.orders_details_information_label,
                  icon: Icons.info_outline,
                  iconColor: theme.primaryColor,
                  child: Column(
                    children: [
                      _buildOrderDetail(
                        icon: Icons.calendar_today,
                        iconColor: Colors.blue[700]!,
                        label: AppLocalizations.of(context)!.orders_details_date_label,
                        value: _formatDate(order.createdAt),
                      ),
                      _buildOrderDetail(
                        icon: Icons.credit_card,
                        iconColor: Colors.amber[700]!,
                        label: AppLocalizations.of(context)!.orders_details_payment_method_label,
                        value: order.paymentMethod ?? 'PayPal',
                      ),
                      _buildOrderDetail(
                        icon: Icons.info_outline,
                        iconColor: statusConfig['color'],
                        label: AppLocalizations.of(context)!.orders_details_status_label,
                        value: statusConfig['label'],
                        valueColor: statusConfig['color'],
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Items Card
                _buildCardSection(
                  title: '${AppLocalizations.of(context)!.orders_details_items_label} (${order.items.length})',
                  icon: Icons.shopping_bag_outlined,
                  iconColor: Colors.teal[700]!,
                  child: Column(
                    children: [
                      const SizedBox(height: 8),
                      ...order.items.map((item) => _buildItemCard(item, coinExchangeProvider, theme)),
                    ],
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Payment Summary
                _buildCardSection(
                  title: AppLocalizations.of(context)!.orders_details_payment_summary_label,
                  icon: Icons.receipt_long,
                  iconColor: Colors.green[700]!,
                  child: Column(
                    children: [
                      _buildPaymentDetail(
                        label: AppLocalizations.of(context)!.orders_details_subtotal_label,
                        value: coinExchangeProvider.formatPrice(
                          coinExchangeProvider.convertPrice(order.totalAmount)
                        ),
                      ),
                      _buildPaymentDetail(
                        label: AppLocalizations.of(context)!.orders_details_shipping_label,
                        value: AppLocalizations.of(context)!.orders_details_free,
                      ),
                      const Divider(height: 24),
                      _buildPaymentDetail(
                        label: 'Total',
                        value: coinExchangeProvider.formatPrice(
                          coinExchangeProvider.convertPrice(order.totalAmount)
                        ),
                        isTotal: true,
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        icon: const Icon(Icons.list_alt),
                        label: Text(
                          AppLocalizations.of(context)!.orders_details_view_all_orders_button,
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                        ),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          side: BorderSide(color: theme.primaryColor),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/orders');
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.shopping_cart),
                        label: Text(
                          AppLocalizations.of(context)!.orders_details_shop_button,
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.primaryColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context, 
                            MaterialPageRoute(
                              builder: (context) => MainScreen(withPageIndex: 1),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardSection({
    required String title,
    required IconData icon,
    required Color iconColor,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(0, 0, 0, 0.05),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: iconColor.withAlpha((0.1 * 255).toInt()),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: iconColor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          
          // Divider
          Divider(height: 1, thickness: 1, color: Colors.grey[100]),
          
          // Card Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: child,
          ),
        ],
      ),
    );
  }

  Widget _buildOrderDetail({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
    Color? valueColor,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withAlpha((0.1 * 255).toInt()),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 18,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.poppins(
                    color: Colors.grey[600],
                    fontSize: 13,
                  ),
                ),
                Text(
                  value,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: valueColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemCard(
    dynamic item, 
    CoinExchangeProvider coinExchangeProvider,
    ThemeData theme,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Icon(
                Icons.shopping_bag,
                color: theme.primaryColor.withAlpha((0.7 * 255).toInt()),
                size: 30,
              ),
            ),
          ),
          const SizedBox(width: 12),
          
          // Product info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.productName,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: theme.primaryColor.withAlpha((0.1 * 255).toInt()),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '${AppLocalizations.of(context)!.orders_details_quantity_label}${item.quantity}',
                        style: GoogleFonts.poppins(
                          color: theme.primaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        coinExchangeProvider.formatPrice(
                          coinExchangeProvider.convertPrice(item.unitPrice)
                        ),
                        style: GoogleFonts.poppins(
                          color: Colors.grey[700],
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Item total price
          Text(
            coinExchangeProvider.formatPrice(
              coinExchangeProvider.convertPrice(item.unitPrice * item.quantity)
            ),
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: theme.primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentDetail({
    required String label,
    required String value,
    bool isTotal = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
              color: isTotal ? Colors.black : Colors.grey[700],
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: isTotal ? 18 : 14,
              fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
              color: isTotal ? Colors.green[700] : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String errorMessage, ThemeData theme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.red[50],
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline,
                color: Colors.red[700],
                size: 64,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Error Loading Order',
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: Colors.red[700],
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              icon: const Icon(Icons.home),
              label: const Text('Go to Home'),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                textStyle: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
                elevation: 3,
              ),
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  '/',
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return DateFormat('dd MMM yyyy, HH:mm').format(date);
  }

  Map<String, dynamic> _getStatusConfig(String status) {
    switch (status) {
      case 'paid':
        return {
          'color': Colors.green[700]!,
          'label': AppLocalizations.of(context)!.orders_details_paid_status,
          'icon': Icons.check_circle,
        };
      case 'pending_payment':
        return {
          'color': Colors.orange[700]!,
          'label': 'Pending Payment',
          'icon': Icons.access_time,
        };
      case 'cancelled':
        return {
          'color': Colors.red[700]!,
          'label': 'Cancelled',
          'icon': Icons.cancel,
        };
      case 'processing':
        return {
          'color': Colors.blue[700]!,
          'label': 'Processing',
          'icon': Icons.sync,
        };
      case 'shipped':
        return {
          'color': Colors.indigo[700]!,
          'label': 'Shipped',
          'icon': Icons.local_shipping,
        };
      case 'delivered':
        return {
          'color': Colors.teal[700]!,
          'label': 'Delivered',
          'icon': Icons.check_circle,
        };
      default:
        return {
          'color': Colors.grey[700]!,
          'label': status.split('_').map((word) => word[0].toUpperCase() + word.substring(1)).join(' '),
          'icon': Icons.help_outline,
        };
    }
  }
}

