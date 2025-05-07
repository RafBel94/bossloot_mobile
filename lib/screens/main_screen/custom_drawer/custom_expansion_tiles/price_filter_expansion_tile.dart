import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PriceFilterExpansionTile extends StatefulWidget {
  const PriceFilterExpansionTile({super.key});

  @override
  State<PriceFilterExpansionTile> createState() => _PriceFilterExpansionTileState();
}

class _PriceFilterExpansionTileState extends State<PriceFilterExpansionTile> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      backgroundColor: const Color.fromARGB(255, 220, 220, 220),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: const Color.fromARGB(255, 204, 204, 204)
        )
      ),
      title: Row(children: [Icon(Icons.payments_outlined), SizedBox(width: 10), Text(AppLocalizations.of(context)!.app_price)],),
      children: [
        // ASCENDENT PRICE FILTER
        ListTile(
            contentPadding: EdgeInsets.only(left: 40),
            tileColor: const Color.fromARGB(255, 242, 242, 242),
            title: Row(children: [Icon(Icons.arrow_upward), SizedBox(width: 10), Text(AppLocalizations.of(context)!.app_ascending)],),
            onTap: () {
              // Handle sub-item 1 tap
            },
          ),

        // DESCENDENT PRICE FILTER
        ListTile(
          contentPadding: EdgeInsets.only(left: 40),
          tileColor: const Color.fromARGB(255, 242, 242, 242),
          title: Row(children: [Icon(Icons.arrow_downward), SizedBox(width: 10), Text(AppLocalizations.of(context)!.app_descending)],),
          onTap: () {
            // Handle sub-item 2 tap
          },
        ),

        // MIN PRICE FILTER
        ListTile(
          contentPadding: EdgeInsets.only(left: 40),
          tileColor: const Color.fromARGB(255, 242, 242, 242),
          title: Row(
            children: [
              Text('${AppLocalizations.of(context)!.app_minimum}: '),
              SizedBox(width: 5),
              Expanded(
                child: TextField(
                decoration: InputDecoration(
                  constraints: BoxConstraints(
                  maxWidth: 10,
                  maxHeight: 40,
                  ),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 5),
                  filled: true,
                  fillColor: Colors.white,
                ),
                keyboardType: TextInputType.number,
                ),
              ),

              SizedBox(width: 30)
            ],
          ),
        ),

        // MAX PRICE FILTER
        ListTile(
          contentPadding: EdgeInsets.only(left: 40),
          tileColor: const Color.fromARGB(255, 242, 242, 242),
          title: Row(
            children: [
              Text('${AppLocalizations.of(context)!.app_maximum}: '),
              SizedBox(width: 5),
              Expanded(
                child: TextField(
                decoration: InputDecoration(
                  constraints: BoxConstraints(
                  maxWidth: 10,
                  maxHeight: 40,
                  ),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 5),
                  filled: true,
                  fillColor: Colors.white,
                ),
                keyboardType: TextInputType.number,
                ),
              ),

              SizedBox(width: 30)
            ],
          ),
        ),

      ],
    );
  }
}