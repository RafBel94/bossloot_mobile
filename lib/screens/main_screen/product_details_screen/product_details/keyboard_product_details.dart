import 'package:bossloot_mobile/domain/models/products/keyboard_product.dart';
import 'package:bossloot_mobile/utils/text_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class KeyboardProductDetails extends StatelessWidget {
  final KeyboardProduct product;
  const KeyboardProductDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextUtil(text: 
        AppLocalizations.of(context)!.product_details_screen_specifications_label, isBold: true, size: 22,),

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
                TextUtil(text: '${AppLocalizations.of(context)!.product_spec_type}: ', isBold: true, size: 16,),
                TextUtil(text: product.type, size: 16,),
              ],
            ),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.memory_outlined),
                SizedBox(width: 5,),
                TextUtil(text: '${AppLocalizations.of(context)!.product_spec_switch_type}: ', isBold: true, size: 16,),
                TextUtil(text: product.switch_type, size: 16,),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.square_foot_outlined),
                SizedBox(width: 5,),
                TextUtil(text: '${AppLocalizations.of(context)!.product_spec_width}: ', isBold: true, size: 16,),
                TextUtil(text: '${product.width.round()} mm', size: 16,),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.square_foot_outlined),
                SizedBox(width: 5,),
                TextUtil(text: '${AppLocalizations.of(context)!.product_spec_height}: ', isBold: true, size: 16,),
                TextUtil(text: '${product.height.round()} mm', size: 16,),
              ],
            ),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.balance),
                SizedBox(width: 5,),
                TextUtil(text: '${AppLocalizations.of(context)!.product_spec_weight}: ', isBold: true, size: 16,),
                TextUtil(text: '${product.weight.round()} g', size: 16,),
              ],
            ),
          ],
        ),
      ],
    );
  }
}