import 'package:bossloot_mobile/domain/models/products/cpu_product.dart';
import 'package:bossloot_mobile/utils/text_util.dart';
import 'package:flutter/material.dart';

class CpuProductDetails extends StatelessWidget {
  final CpuProduct product;
  const CpuProductDetails({super.key, required this.product});

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
                Icon(Icons.extension),
                SizedBox(width: 5,),
                TextUtil(text: 'Socket: ', isBold: true, size: 16,),
                TextUtil(text: product.socket, size: 16,),
              ],
            ),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.memory),
                SizedBox(width: 5,),
                TextUtil(text: 'Cores: ', isBold: true, size: 16,),
                TextUtil(text: '${product.coreCount}', size: 16,),
              ],
            ),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.settings_input_component_outlined),
                SizedBox(width: 5,),
                TextUtil(text: 'Threads: ', isBold: true, size: 16,),
                TextUtil(text: '${product.thread_count}', size: 16,),
              ],
            ),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.bolt),
                SizedBox(width: 5,),
                TextUtil(text: 'Base clock speed: ', isBold: true, size: 16,),
                TextUtil(text: '${product.base_clock} MHz', size: 16,),
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
                Icon(Icons.palette_outlined),
                SizedBox(width: 5,),
                TextUtil(text: 'Integrated graphics: ', isBold: true, size: 16,),
                TextUtil(text: product.integrated_graphics ? 'Yes' : 'No', size: 16,),
              ],
            ),
          ],
        ),
      ],
    );
  }
}