import 'package:bossloot_mobile/domain/models/products/motherboard_product.dart';
import 'package:bossloot_mobile/utils/text_util.dart';
import 'package:flutter/material.dart';

class MotherboardProductDetails extends StatelessWidget {
  final MotherboardProduct product;
  const MotherboardProductDetails({super.key, required this.product});

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
                TextUtil(text: 'Socket: ', isBold: true, size: 16,),
                TextUtil(text: product.socket, size: 16,),
              ],
            ),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.memory_outlined),
                SizedBox(width: 5,),
                TextUtil(text: 'Chipset: ', isBold: true, size: 16,),
                TextUtil(text: product.chipset, size: 16,),
              ],
            ),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.dashboard_outlined),
                SizedBox(width: 5,),
                TextUtil(text: 'Form factor: ', isBold: true, size: 16,),
                TextUtil(text: product.form_factor, size: 16,),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.extension_outlined),
                SizedBox(width: 5,),
                TextUtil(text: 'Memory type: ', isBold: true, size: 16,),
                TextUtil(text: product.memory_type, size: 16,),
              ],
            ),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.storage_outlined),
                SizedBox(width: 5,),
                TextUtil(text: 'Maximum memory: ', isBold: true, size: 16,),
                TextUtil(text: '${product.memory_max} GB', size: 16,),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.playlist_add),
                SizedBox(width: 5,),
                TextUtil(text: 'Memory slots: ', isBold: true, size: 16,),
                TextUtil(text: '${product.memory_slots}', size: 16,),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.bolt),
                SizedBox(width: 5,),
                TextUtil(text: 'Maximum memory speed: ', isBold: true, size: 16,),
                TextUtil(text: '${product.memory_speed} MHz', size: 16,),
              ],
            ),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.adf_scanner_sharp),
                SizedBox(width: 5,),
                TextUtil(text: 'SATA ports: ', isBold: true, size: 16,),
                TextUtil(text: '${product.sata_ports}', size: 16,),
              ],
            ),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.adf_scanner_sharp),
                SizedBox(width: 5,),
                TextUtil(text: 'M2 ports: ', isBold: true, size: 16,),
                TextUtil(text: '${product.m_2_slots}', size: 16,),
              ],
            ),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.memory_outlined),
                SizedBox(width: 5,),
                TextUtil(text: 'PCI-E slots: ', isBold: true, size: 16,),
                TextUtil(text: '${product.pcie_slots}', size: 16,),
              ],
            ),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.usb_outlined),
                SizedBox(width: 5,),
                TextUtil(text: 'USB slots: ', isBold: true, size: 16,),
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
                TextUtil(text: product.wifi ? 'Yes' : 'No', size: 16,),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.bluetooth),
                SizedBox(width: 5,),
                TextUtil(text: 'Bluetooth: ', isBold: true, size: 16,),
                TextUtil(text: product.bluetooth ? 'Yes' : 'No', size: 16,),
              ],
            ),
          ],
        ),
      ],
    );
  }
}