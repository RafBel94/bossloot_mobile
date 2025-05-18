// lib/widgets/cart_item_card.dart
import 'package:bossloot_mobile/domain/models/cart/cart_item.dart';
import 'package:bossloot_mobile/providers/coin_exchange_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItemCard extends StatelessWidget {
  final CartItem item;
  final Function(int) onQuantityChanged;
  final VoidCallback onRemove;

  const CartItemCard({super.key, 
    required this.item,
    required this.onQuantityChanged,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    CoinExchangeProvider coinExchangeProvider = context.read<CoinExchangeProvider>();

    return Card(
      color: const Color.fromARGB(255, 255, 255, 255),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        side: BorderSide(
          color: const Color.fromARGB(26, 202, 13, 219),
          width: 1,
        ),
      ),
      shadowColor: const Color.fromARGB(189, 188, 13, 204),
      elevation: 3,
      margin: EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Product image
            if (item.product?.image != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  item.product!.image!,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              )
            else
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[200],
                ),
                child: Icon(
                  Icons.image_not_supported,
                  color: Colors.grey[400],
                ),
              ),
            SizedBox(width: 16),
            // Product info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      item.product?.name ?? 'Product',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 4),
    
                  // Price and discount
                  Row(
                    children: [
                      if (item.product?.discount != null && item.product!.discount! > 0)
                      Text(
                        coinExchangeProvider.formatPrice(coinExchangeProvider.convertPrice(item.product!.price)),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
    
                      const SizedBox(width: 8),
    
                      Text(
                        coinExchangeProvider.formatPrice(coinExchangeProvider.convertPrice(item.unitPrice)),
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
    
                  SizedBox(height: 8),
    
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Quantity controls
                      Row(
                        children: [
                          _buildQuantityButton(
                            icon: Icons.remove,
                            onPressed: item.quantity > 1
                                ? () => onQuantityChanged(item.quantity - 1)
                                : null,
                          ),
    
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: Colors.grey[300]!),
                            ),
                            child: Text(
                              '${item.quantity}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
    
                          _buildQuantityButton(
                            icon: Icons.add,
                            onPressed: () =>
                                onQuantityChanged(item.quantity + 1),
                          ),
                        ],
                      ),
    
                      // Remove button
                      IconButton(
                        icon: Icon(Icons.delete_outline),
                        color: Colors.red,
                        onPressed: onRemove,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuantityButton({
    required IconData icon,
    VoidCallback? onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: onPressed == null ? Colors.grey[300]! : Colors.grey[400]!,
        ),
      ),
      child: SizedBox(
        height: 35,
        width: 35,
        child: IconButton(
          icon: Icon(icon, size: 14),
          color: onPressed == null ? Colors.grey[400] : Colors.black87,
          padding: EdgeInsets.zero,
          visualDensity: VisualDensity.compact,
          constraints: BoxConstraints(),
          onPressed: onPressed,
        ),
      ),
    );
  }
}