import 'package:flutter/material.dart';

class BrandFilterExpansionTile extends StatefulWidget {
  const BrandFilterExpansionTile({super.key});

  @override
  State<BrandFilterExpansionTile> createState() => _BrandFilterExpansionTileState();
}

class _BrandFilterExpansionTileState extends State<BrandFilterExpansionTile> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      backgroundColor: const Color.fromARGB(255, 220, 220, 220),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: const Color.fromARGB(255, 204, 204, 204)
        )
      ),
      title: Row(children: [Icon(Icons.copyright_outlined), SizedBox(width: 10), Text('Brand')],),
        children: [
          ListTile(
            contentPadding: EdgeInsets.only(left: 40),
            tileColor: const Color.fromARGB(255, 242, 242, 242),
            title: Row(children: [Icon(Icons.more_horiz_outlined), SizedBox(width: 10), Text('AMD')],),
            onTap: () {
              // Handle sub-item 1 tap
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 40),
            tileColor: const Color.fromARGB(255, 242, 242, 242),
            title: Row(children: [Icon(Icons.more_horiz_outlined), SizedBox(width: 10), Text('Corsair')],),
            onTap: () {
              // Handle sub-item 2 tap
            },
          ),
        ],
    );
  }
}