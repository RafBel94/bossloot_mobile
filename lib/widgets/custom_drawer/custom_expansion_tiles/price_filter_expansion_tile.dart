import 'package:bossloot_mobile/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class PriceFilterExpansionTile extends StatefulWidget {
  const PriceFilterExpansionTile({super.key});

  @override
  State<PriceFilterExpansionTile> createState() => _PriceFilterExpansionTileState();
}

class _PriceFilterExpansionTileState extends State<PriceFilterExpansionTile> {
  final TextEditingController _minPriceController = TextEditingController();
  final TextEditingController _maxPriceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final productProvider = Provider.of<ProductProvider>(context, listen: false);
      if (productProvider.minPrice != null) {
        _minPriceController.text = productProvider.minPrice.toString();
      }
      if (productProvider.maxPrice != null) {
        _maxPriceController.text = productProvider.maxPrice.toString();
      }
    });
  }

  @override
  void dispose() {
    _minPriceController.dispose();
    _maxPriceController.dispose();
    super.dispose();
  }

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
      title: Row(children: [Icon(Icons.payments_outlined), SizedBox(width: 10), Text(AppLocalizations.of(context)!.app_price)],),
      children: [
        // ASCENDENT PRICE FILTER
        ListTile(
          contentPadding: EdgeInsets.only(left: 40),
          tileColor: const Color.fromARGB(255, 242, 242, 242),
          selected: productProvider.priceOrder == 'asc',
          selectedTileColor: const Color.fromRGBO(33, 150, 243, 0.2),
          title: Row(
            children: [
              Icon(
                Icons.arrow_upward,
                color: productProvider.priceOrder == 'asc' ? Colors.blue : Colors.grey,
              ), 
              SizedBox(width: 10), 
              Text(AppLocalizations.of(context)!.app_ascending)
            ],
          ),
          onTap: () {
            productProvider.setPriceOrder(productProvider.priceOrder == 'asc' ? '' : 'asc');
            if (productProvider.priceOrder == 'asc') {
              // Si seleccionamos ascendente, desactivamos descendente
              productProvider.setPriceOrder('asc');
            }
          },
        ),

        // DESCENDENT PRICE FILTER
        ListTile(
          contentPadding: EdgeInsets.only(left: 40),
          tileColor: const Color.fromARGB(255, 242, 242, 242),
          selected: productProvider.priceOrder == 'desc',
          selectedTileColor: const Color.fromRGBO(33, 150, 243, 0.2),
          title: Row(
            children: [
              Icon(
                Icons.arrow_downward,
                color: productProvider.priceOrder == 'desc' ? Colors.blue : Colors.grey,
              ), 
              SizedBox(width: 10), 
              Text(AppLocalizations.of(context)!.app_descending)
            ],
          ),
          onTap: () {
            productProvider.setPriceOrder(productProvider.priceOrder == 'desc' ? '' : 'desc');
            if (productProvider.priceOrder == 'desc') {
              // Si seleccionamos descendente, desactivamos ascendente
              productProvider.setPriceOrder('desc');
            }
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
                  controller: _minPriceController,
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
                  onChanged: (value) {
                    if (value.isEmpty) {
                      productProvider.setMinPrice(null);
                    } else {
                      try {
                        double minPrice = double.parse(value);
                        productProvider.setMinPrice(minPrice);
                      } catch (e) {
                        // Ignorar entradas no numéricas
                      }
                    }
                  },
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
                  controller: _maxPriceController,
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
                  onChanged: (value) {
                    if (value.isEmpty) {
                      productProvider.setMaxPrice(null);
                    } else {
                      try {
                        double maxPrice = double.parse(value);
                        productProvider.setMaxPrice(maxPrice);
                      } catch (e) {
                        // Ignorar entradas no numéricas
                      }
                    }
                  },
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