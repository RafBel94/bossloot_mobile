import 'package:bossloot_mobile/domain/models/products/mouse_product.dart';
import 'package:bossloot_mobile/utils/text_util.dart';
import 'package:flutter/material.dart';

class MouseProductDetails extends StatelessWidget {
  final MouseProduct product;
  const MouseProductDetails({super.key, required this.product});

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
                Icon(Icons.speed),
                SizedBox(width: 5,),
                TextUtil(text: 'DPI: ', isBold: true, size: 16,),
                TextUtil(text: '${product.dpi}', size: 16,),
              ],
            ),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.sensors),
                SizedBox(width: 5,),
                TextUtil(text: 'Sensor: ', isBold: true, size: 16,),
                TextUtil(text: product.sensor, size: 16,),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.widgets_outlined),
                SizedBox(width: 5,),
                TextUtil(text: 'Buttons: ', isBold: true, size: 16,),
                TextUtil(text: '${product.buttons}', size: 16,),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.bluetooth),
                SizedBox(width: 5,),
                TextUtil(text: 'Bluetooth: ', isBold: true, size: 16,),
                TextUtil(text: product.bluetooth ? 'Yes' : 'No', size: 16,),
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