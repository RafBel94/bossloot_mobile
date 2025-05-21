import 'package:bossloot_mobile/providers/brand_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class BrandFilterExpansionTile extends StatefulWidget {
  const BrandFilterExpansionTile({super.key});

  @override
  State<BrandFilterExpansionTile> createState() => _BrandFilterExpansionTileState();
}

class _BrandFilterExpansionTileState extends State<BrandFilterExpansionTile> {
  @override
  Widget build(BuildContext context) {

  BrandProvider brandProvider = context.watch<BrandProvider>();
  final brands = brandProvider.brands.where((brand) => brand.name != 'No Brand').toList();

    return ExpansionTile(
      backgroundColor: const Color.fromARGB(255, 220, 220, 220),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: const Color.fromARGB(255, 204, 204, 204)
        )
      ),
      title: Row(children: [Icon(Icons.copyright_outlined), SizedBox(width: 10), Text(AppLocalizations.of(context)!.app_drawer_brand_label)],),
      children: brands.map((brand) {
        return ListTile(
          contentPadding: EdgeInsets.only(left: 40),
          tileColor: const Color.fromARGB(255, 242, 242, 242),
          title: Row(
              children: [
              Icon(Icons.double_arrow_sharp, size: 12),
              SizedBox(width: 8),
              Text(brand.name.split(' ').take(2).join(' ')),
            ],
          ),
          onTap: () {

          },
        );
      }).toList(),
    );
  }
}