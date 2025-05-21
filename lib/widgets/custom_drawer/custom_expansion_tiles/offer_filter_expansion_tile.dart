import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:bossloot_mobile/providers/product_provider.dart';

class OfferFilterExpansionTile extends StatefulWidget {
  const OfferFilterExpansionTile({super.key});

  @override
  State<OfferFilterExpansionTile> createState() => _OfferFilterExpansionTileState();
}

class _OfferFilterExpansionTileState extends State<OfferFilterExpansionTile> {
  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = context.watch<ProductProvider>();
    
    return ExpansionTile(
      backgroundColor: const Color.fromARGB(255, 220, 220, 220),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: const Color.fromARGB(255, 204, 204, 204)
        )
      ),
      title: Row(
        children: [
          Icon(Icons.discount_outlined), 
          SizedBox(width: 10), 
          Text(AppLocalizations.of(context)!.app_drawer_offer_label),
        ],
      ),
      children: [
        // Único elemento: Mostrar solo productos en oferta
        ListTile(
          contentPadding: EdgeInsets.only(left: 40),
          tileColor: const Color.fromARGB(255, 242, 242, 242),
          selected: productProvider.filterOnOffer,
          selectedTileColor: const Color.fromRGBO(33, 150, 243, 0.2),
          title: Row(
            children: [
              Icon(
                productProvider.filterOnOffer ? Icons.check_box : Icons.check_box_outline_blank,
                size: 16,
                color: productProvider.filterOnOffer ? Colors.blue : Colors.grey,
              ),
              SizedBox(width: 10),
              Text(AppLocalizations.of(context)!.app_drawer_only_offers_label),
            ],
          ),
          onTap: () {
            productProvider.toggleOnOfferFilter(!productProvider.filterOnOffer);
          },
        ),
      ],
    );
  }
}