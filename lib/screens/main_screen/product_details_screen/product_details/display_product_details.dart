import 'package:bossloot_mobile/domain/models/products/display_product.dart';
import 'package:bossloot_mobile/utils/text_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DisplayProductDetails extends StatelessWidget {
  final DisplayProduct product;
  const DisplayProductDetails({super.key, required this.product});

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
                Icon(Icons.screenshot_monitor_outlined),
                SizedBox(width: 5,),
                TextUtil(text: '${AppLocalizations.of(context)!.product_spec_resolution}: ', isBold: true, size: 16,),
                TextUtil(text: product.resolution, size: 16,),
              ],
            ),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.refresh),
                SizedBox(width: 5,),
                TextUtil(text: '${AppLocalizations.of(context)!.product_spec_refresh_rate}: ', isBold: true, size: 16,),
                TextUtil(text: '${product.refresh_rate} Hz', size: 16,),
              ],
            ),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.electric_bolt_outlined),
                SizedBox(width: 5,),
                TextUtil(text: '${AppLocalizations.of(context)!.product_spec_response_time}: ', isBold: true, size: 16,),
                TextUtil(text: '${product.response_time} ms', size: 16,),
              ],
            ),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.memory),
                SizedBox(width: 5,),
                TextUtil(text: '${AppLocalizations.of(context)!.product_spec_panel_type}: ', isBold: true, size: 16,),
                TextUtil(text: product.panel_type, size: 16,),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.shape_line_outlined),
                SizedBox(width: 5,),
                TextUtil(text: '${AppLocalizations.of(context)!.product_spec_aspect_ratio}: ', isBold: true, size: 16,),
                TextUtil(text: product.aspect_ratio, size: 16,),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.shape_line_outlined),
                SizedBox(width: 5,),
                TextUtil(text: '${AppLocalizations.of(context)!.product_spec_contrast_ratio}: ', isBold: true, size: 16,),
                TextUtil(text: product.contrast_ratio, size: 16,),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.sync_alt),
                SizedBox(width: 5,),
                TextUtil(text: '${AppLocalizations.of(context)!.product_spec_sync_type}: ', isBold: true, size: 16,),
                TextUtil(text: product.sync_type, size: 16,),
              ],
            ),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.switch_access_shortcut),
                SizedBox(width: 5,),
                TextUtil(text: '${AppLocalizations.of(context)!.product_spec_curved}: ', isBold: true, size: 16,),
                TextUtil(text: product.curved ? AppLocalizations.of(context)!.app_yes : 'No', size: 16,),
              ],
            ),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.brightness_4_outlined),
                SizedBox(width: 5,),
                TextUtil(text: '${AppLocalizations.of(context)!.product_spec_brightness}: ', isBold: true, size: 16,),
                TextUtil(text: '${product.brightness}', size: 16,),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.settings_input_hdmi_outlined),
                SizedBox(width: 5,),
                TextUtil(text: '${AppLocalizations.of(context)!.product_spec_hdmi_ports}: ', isBold: true, size: 16,),
                TextUtil(text: '${product.hdmi_ports}', size: 16,),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.settings_input_hdmi_outlined),
                SizedBox(width: 5,),
                TextUtil(text: '${AppLocalizations.of(context)!.product_spec_display_ports}: ', isBold: true, size: 16,),
                TextUtil(text: '${product.display_ports}', size: 16,),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.square_foot),
                SizedBox(width: 5,),
                TextUtil(text: '${AppLocalizations.of(context)!.product_spec_inches}: ', isBold: true, size: 16,),
                TextUtil(text: '${product.inches}', size: 16,),
              ],
            ),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.balance),
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