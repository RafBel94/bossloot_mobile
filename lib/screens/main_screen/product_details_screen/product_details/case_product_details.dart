import 'package:bossloot_mobile/domain/models/products/case_product.dart';
import 'package:bossloot_mobile/utils/text_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CaseProductDetails extends StatelessWidget {
  final CaseProduct product;
  const CaseProductDetails({super.key, required this.product});

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
                TextUtil(text: product.case_type, size: 16,),
              ],
            ),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.widgets_outlined),
                SizedBox(width: 5,),
                TextUtil(text: '${AppLocalizations.of(context)!.product_spec_form_factor_support}: ', isBold: true, size: 16,),
                TextUtil(text: product.form_factor_support, size: 16,),
              ],
            ),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.local_bar_outlined),
                SizedBox(width: 5,),
                TextUtil(text: '${AppLocalizations.of(context)!.product_spec_tempered_glass}: ', isBold: true, size: 16,),
                TextUtil(text: product.tempered_glass ? 'Yes' : 'No', size: 16,),
              ],
            ),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.dashboard_customize_outlined),
                SizedBox(width: 5,),
                TextUtil(text: '${AppLocalizations.of(context)!.product_spec_expansion_slots}: ', isBold: true, size: 16,),
                TextUtil(text: '${product.expansion_slots}', size: 16,),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.dashboard_customize_outlined),
                SizedBox(width: 5,),
                TextUtil(text: '${AppLocalizations.of(context)!.product_spec_extra_fans_slots}: ', isBold: true, size: 16,),
                TextUtil(text: '${product.extra_fans_connectors}', size: 16,),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.square_foot),
                SizedBox(width: 5,),
                TextUtil(text: '${AppLocalizations.of(context)!.product_spec_max_gpu_length}: ', isBold: true, size: 16,),
                TextUtil(text: '${product.max_gpu_length.round()} mm', size: 16,),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.square_foot),
                SizedBox(width: 5,),
                TextUtil(text: '${AppLocalizations.of(context)!.product_spec_max_cpu_cooler_height}: ', isBold: true, size: 16,),
                TextUtil(text: '${product.max_cpu_cooler_height.round()} mm', size: 16,),
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
        
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.square_foot),
                SizedBox(width: 5,),
                TextUtil(text: '${AppLocalizations.of(context)!.product_spec_depth}: ', isBold: true, size: 16,),
                TextUtil(text: '${product.depth.round()} mm', size: 16,),
              ],
            ),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.square_foot),
                SizedBox(width: 5,),
                TextUtil(text: '${AppLocalizations.of(context)!.product_spec_weight}: ', isBold: true, size: 16,),
                TextUtil(text: '${product.weight.round()} Kg', size: 16,),
              ],
            ),
          ],
        ),
      ],
    );
  }
}