import 'package:bossloot_mobile/domain/models/products/storage_product.dart';
import 'package:bossloot_mobile/utils/text_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StorageProductDetails extends StatelessWidget {
  final StorageProduct product;
  const StorageProductDetails({super.key, required this.product});

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
                Icon(Icons.storage_outlined),
                SizedBox(width: 5,),
                TextUtil(text: '${AppLocalizations.of(context)!.product_spec_capacity}: ', isBold: true, size: 16,),
                TextUtil(text: '${product.capacity}', size: 16,),
              ],
            ),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.speed),
                SizedBox(width: 5,),
                TextUtil(text: 'RPM: ', isBold: true, size: 16,),
                TextUtil(text: '${product.rpm} rpm', size: 16,),
              ],
            ),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.timer_sharp),
                SizedBox(width: 5,),
                TextUtil(text: '${AppLocalizations.of(context)!.product_spec_read_speed}: ', isBold: true, size: 16,),
                TextUtil(text: '${product.readSpeed} Mb/s', size: 16,),
              ],
            ),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.edit),
                SizedBox(width: 5,),
                TextUtil(text: '${AppLocalizations.of(context)!.product_spec_write_speed}: ', isBold: true, size: 16,),
                TextUtil(text: '${product.writeSpeed} Mb/s', size: 16,),
              ],
            ),
          ],
        ),
      ],
    );
  }
}