import 'package:bossloot_mobile/domain/models/products/cooler_product.dart';
import 'package:bossloot_mobile/utils/text_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CoolerProductDetails extends StatelessWidget {
  final CoolerProduct product;
  const CoolerProductDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextUtil(text: AppLocalizations.of(context)!.product_details_screen_specifications_label, isBold: true, size: 22,),

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
                TextUtil(text: '${AppLocalizations.of(context)!.product_spec_type}: ', isBold: true, size: 16,),
                TextUtil(text: product.type, size: 16,),
              ],
            ),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.speed),
                SizedBox(width: 5,),
                TextUtil(text: '${AppLocalizations.of(context)!.product_spec_fan_rpm}: ', isBold: true, size: 16,),
                TextUtil(text: '${product.fan_rpm} rpm', size: 16,),
              ],
            ),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.battery_5_bar),
                SizedBox(width: 5,),
                TextUtil(text: '${AppLocalizations.of(context)!.product_spec_consumption}: ', isBold: true, size: 16,),
                TextUtil(text: '${product.consumption} W', size: 16,),
              ],
            ),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.widgets_outlined),
                SizedBox(width: 5,),
                TextUtil(text: '${AppLocalizations.of(context)!.product_spec_socket_support}: ', isBold: true, size: 16,),
                TextUtil(text: product.socket_support, size: 16,),
              ],
            ),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.square_foot),
                SizedBox(width: 5,),
                TextUtil(text: '${AppLocalizations.of(context)!.product_spec_width}: ', isBold: true, size: 16,),
                TextUtil(text: '${product.width.round()} mm', size: 16,),
              ],
            ),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.square_foot),
                SizedBox(width: 5,),
                TextUtil(text: '${AppLocalizations.of(context)!.product_spec_height}: ', isBold: true, size: 16,),
                TextUtil(text: '${product.height.round()} mm', size: 16,),
              ],
            ),
          ],
        ),
      ],
    );
  }
}