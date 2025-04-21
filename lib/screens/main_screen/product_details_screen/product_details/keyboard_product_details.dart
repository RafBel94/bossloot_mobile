import 'package:bossloot_mobile/domain/models/products/keyboard_product.dart';
import 'package:bossloot_mobile/utils/text_util.dart';
import 'package:flutter/material.dart';

class KeyboardProductDetails extends StatelessWidget {
  final KeyboardProduct product;
  const KeyboardProductDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextUtil(text: 'Specifications', isBold: true, size: 22,),

        SizedBox(height: 20,),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.category_outlined),
                SizedBox(width: 5,),
                TextUtil(text: 'Type: ', isBold: true, size: 16,),
                TextUtil(text: product.type, size: 16,),
              ],
            ),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.memory_outlined),
                SizedBox(width: 5,),
                TextUtil(text: 'Switch type: ', isBold: true, size: 16,),
                TextUtil(text: product.switch_type, size: 16,),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.square_foot_outlined),
                SizedBox(width: 5,),
                TextUtil(text: 'Width: ', isBold: true, size: 16,),
                TextUtil(text: '${product.width.round()} mm', size: 16,),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.square_foot_outlined),
                SizedBox(width: 5,),
                TextUtil(text: 'Height: ', isBold: true, size: 16,),
                TextUtil(text: '${product.height.round()} mm', size: 16,),
              ],
            ),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.balance),
                SizedBox(width: 5,),
                TextUtil(text: 'Weight: ', isBold: true, size: 16,),
                TextUtil(text: '${product.weight.round()} g', size: 16,),
              ],
            ),
          ],
        ),
      ],
    );
  }
}