import 'package:bossloot_mobile/domain/models/products/motherboard_product.dart';
import 'package:bossloot_mobile/utils/text_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MotherboardProductDetails extends StatelessWidget {
  final MotherboardProduct product;
  const MotherboardProductDetails({super.key, required this.product});

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
                TextUtil(text: '${AppLocalizations.of(context)!.product_spec_socket}: ', isBold: true, size: 16,),
                TextUtil(text: product.socket, size: 16,),
              ],
            ),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.memory_outlined),
                SizedBox(width: 5,),
                TextUtil(text: '${AppLocalizations.of(context)!.product_spec_chipset}: ', isBold: true, size: 16,),
                TextUtil(text: product.chipset, size: 16,),
              ],
            ),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.dashboard_outlined),
                SizedBox(width: 5,),
                TextUtil(text: '${AppLocalizations.of(context)!.product_spec_form_factor}: ', isBold: true, size: 16,),
                TextUtil(text: product.form_factor, size: 16,),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.extension_outlined),
                SizedBox(width: 5,),
                TextUtil(text: '${AppLocalizations.of(context)!.product_spec_memory_type}: ', isBold: true, size: 16,),
                TextUtil(text: product.memory_type, size: 16,),
              ],
            ),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.storage_outlined),
                SizedBox(width: 5,),
                TextUtil(text: '${AppLocalizations.of(context)!.product_spec_maximum_memory}: ', isBold: true, size: 16,),
                TextUtil(text: '${product.memory_max} GB', size: 16,),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.playlist_add),
                SizedBox(width: 5,),
                TextUtil(text: '${AppLocalizations.of(context)!.product_spec_memory_slots}: ', isBold: true, size: 16,),
                TextUtil(text: '${product.memory_slots}', size: 16,),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.bolt),
                SizedBox(width: 5,),
                TextUtil(text: '${AppLocalizations.of(context)!.product_spec_maximum_memory_speed}: ', isBold: true, size: 16,),
                TextUtil(text: '${product.memory_speed} MHz', size: 16,),
              ],
            ),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.adf_scanner_sharp),
                SizedBox(width: 5,),
                TextUtil(text: '${AppLocalizations.of(context)!.product_spec_sata_ports}: ', isBold: true, size: 16,),
                TextUtil(text: '${product.sata_ports}', size: 16,),
              ],
            ),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.adf_scanner_sharp),
                SizedBox(width: 5,),
                TextUtil(text: '${AppLocalizations.of(context)!.product_spec_m2_slots}: ', isBold: true, size: 16,),
                TextUtil(text: '${product.m_2_slots}', size: 16,),
              ],
            ),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.memory_outlined),
                SizedBox(width: 5,),
                TextUtil(text: '${AppLocalizations.of(context)!.product_spec_pcie_slots}: ', isBold: true, size: 16,),
                TextUtil(text: '${product.pcie_slots}', size: 16,),
              ],
            ),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.usb_outlined),
                SizedBox(width: 5,),
                TextUtil(text: '${AppLocalizations.of(context)!.product_spec_usb_ports}: ', isBold: true, size: 16,),
                TextUtil(text: '${product.usb_ports}', size: 16,),
              ],
            ),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.lan_outlined),
                SizedBox(width: 5,),
                TextUtil(text: 'LAN: ', isBold: true, size: 16,),
                TextUtil(text: product.lan, size: 16,),
              ],
            ),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.audiotrack_outlined),
                SizedBox(width: 5,),
                TextUtil(text: 'Audio: ', isBold: true, size: 16,),
                TextUtil(text: product.audio, size: 16,),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.wifi),
                SizedBox(width: 5,),
                TextUtil(text: 'Wifi: ', isBold: true, size: 16,),
                TextUtil(text: product.wifi ? AppLocalizations.of(context)!.app_yes : 'No', size: 16,),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.bluetooth),
                SizedBox(width: 5,),
                TextUtil(text: 'Bluetooth: ', isBold: true, size: 16,),
                TextUtil(text: product.bluetooth ? AppLocalizations.of(context)!.app_yes : 'No', size: 16,),
              ],
            ),
          ],
        ),
      ],
    );
  }
}