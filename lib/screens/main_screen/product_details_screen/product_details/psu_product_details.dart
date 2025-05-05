import 'package:bossloot_mobile/domain/models/products/psu_product.dart';
import 'package:bossloot_mobile/utils/text_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PsuProductDetails extends StatelessWidget {
  final PsuProduct product;
  const PsuProductDetails({super.key, required this.product});

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
                Icon(Icons.verified_outlined),
                SizedBox(width: 5,),
                TextUtil(text: '${AppLocalizations.of(context)!.product_spec_efficienty_rating}: ', isBold: true, size: 16,),
                TextUtil(text: product.efficiency_rating, size: 16,),
              ],
            ),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.battery_5_bar),
                SizedBox(width: 5,),
                TextUtil(text: '${AppLocalizations.of(context)!.product_spec_wattage}: ', isBold: true, size: 16,),
                TextUtil(text: '${product.wattage} W', size: 16,),
              ],
            ),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.widgets_outlined),
                SizedBox(width: 5,),
                TextUtil(text: 'Modular: ', isBold: true, size: 16,),
                TextUtil(text: product.modular ? AppLocalizations.of(context)!.app_yes : 'No', size: 16,),
              ],
            ),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.mode_fan_off_outlined),
                SizedBox(width: 5,),
                TextUtil(text: '${AppLocalizations.of(context)!.product_spec_fanless}: ', isBold: true, size: 16,),
                TextUtil(text: product.fanless ? AppLocalizations.of(context)!.app_yes : 'No', size: 16,),
              ],
            ),
          ],
        ),
      ],
    );
  }
}