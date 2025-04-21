import 'package:bossloot_mobile/domain/models/products/gpu_product.dart';
import 'package:bossloot_mobile/utils/text_util.dart';
import 'package:flutter/material.dart';

class GpuProductDetails extends StatelessWidget {
  final GpuProduct product;
  const GpuProductDetails({super.key, required this.product});

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
                Icon(Icons.category),
                SizedBox(width: 5,),
                TextUtil(text: 'Memory type: ', isBold: true, size: 16,),
                TextUtil(text: product.memory_type, size: 16,),
              ],
            ),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.memory),
                SizedBox(width: 5,),
                TextUtil(text: 'Memory: ', isBold: true, size: 16,),
                TextUtil(text: '${product.memory} GB', size: 16,),
              ],
            ),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.bolt),
                SizedBox(width: 5,),
                TextUtil(text: 'Base clock speed: ', isBold: true, size: 16,),
                TextUtil(text: '${product.core_clock} MHz', size: 16,),
              ],
            ),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.rocket),
                SizedBox(width: 5,),
                TextUtil(text: 'Boost clock speed: ', isBold: true, size: 16,),
                TextUtil(text: '${product.boost_clock} MHz', size: 16,),
              ],
            ),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.battery_5_bar),
                SizedBox(width: 5,),
                TextUtil(text: 'Consumption: ', isBold: true, size: 16,),
                TextUtil(text: '${product.consumption} W', size: 16,),
              ],
            ),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.square_foot),
                SizedBox(width: 5,),
                TextUtil(text: 'Length: ', isBold: true, size: 16,),
                TextUtil(text: '${product.length.round()} mm', size: 16,),
              ],
            ),
          ],
        ),
      ],
    );
  }
}