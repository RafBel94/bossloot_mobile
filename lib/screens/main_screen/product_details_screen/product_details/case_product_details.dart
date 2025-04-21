import 'package:bossloot_mobile/domain/models/products/case_product.dart';
import 'package:bossloot_mobile/utils/text_util.dart';
import 'package:flutter/material.dart';

class CaseProductDetails extends StatelessWidget {
  final CaseProduct product;
  const CaseProductDetails({super.key, required this.product});

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
                Icon(Icons.extension_outlined),
                SizedBox(width: 5,),
                TextUtil(text: 'Type: ', isBold: true, size: 16,),
                TextUtil(text: product.case_type, size: 16,),
              ],
            ),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.widgets_outlined),
                SizedBox(width: 5,),
                TextUtil(text: 'Form factor support: ', isBold: true, size: 16,),
                TextUtil(text: product.form_factor_support, size: 16,),
              ],
            ),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.local_bar_outlined),
                SizedBox(width: 5,),
                TextUtil(text: 'Tempered glass: ', isBold: true, size: 16,),
                TextUtil(text: product.tempered_glass ? 'Yes' : 'No', size: 16,),
              ],
            ),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.dashboard_customize_outlined),
                SizedBox(width: 5,),
                TextUtil(text: 'Expansion slots: ', isBold: true, size: 16,),
                TextUtil(text: '${product.expansion_slots}', size: 16,),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.dashboard_customize_outlined),
                SizedBox(width: 5,),
                TextUtil(text: 'Extra fans slots: ', isBold: true, size: 16,),
                TextUtil(text: '${product.extra_fans_connectors}', size: 16,),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.square_foot),
                SizedBox(width: 5,),
                TextUtil(text: 'Max GPU length: ', isBold: true, size: 16,),
                TextUtil(text: '${product.max_gpu_length.round()} mm', size: 16,),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.square_foot),
                SizedBox(width: 5,),
                TextUtil(text: 'Max CPU cooler height: ', isBold: true, size: 16,),
                TextUtil(text: '${product.max_cpu_cooler_height.round()} mm', size: 16,),
              ],
            ),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.square_foot),
                SizedBox(width: 5,),
                TextUtil(text: 'Width: ', isBold: true, size: 16,),
                TextUtil(text: '${product.width.round()} mm', size: 16,),
              ],
            ),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.square_foot),
                SizedBox(width: 5,),
                TextUtil(text: 'Height: ', isBold: true, size: 16,),
                TextUtil(text: '${product.height.round()} mm', size: 16,),
              ],
            ),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.square_foot),
                SizedBox(width: 5,),
                TextUtil(text: 'Depth: ', isBold: true, size: 16,),
                TextUtil(text: '${product.depth.round()} mm', size: 16,),
              ],
            ),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.square_foot),
                SizedBox(width: 5,),
                TextUtil(text: 'Weight: ', isBold: true, size: 16,),
                TextUtil(text: '${product.weight.round()} Kg', size: 16,),
              ],
            ),
          ],
        ),
      ],
    );
  }
}