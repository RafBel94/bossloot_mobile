// ignore_for_file: must_be_immutable

import 'package:bossloot_mobile/providers/category_provider.dart';
import 'package:bossloot_mobile/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class CategoryFilterExpansionTile extends StatefulWidget {
  const CategoryFilterExpansionTile({super.key});

  @override
  State<CategoryFilterExpansionTile> createState() => _CategoryFilterExpansionTileState();
}

class _CategoryFilterExpansionTileState extends State<CategoryFilterExpansionTile> {
  @override
  Widget build(BuildContext context) {
    CategoryProvider categoryProvider = context.watch<CategoryProvider>();
    ProductProvider productProvider = context.watch<ProductProvider>();
    
    return ExpansionTile(
      backgroundColor: const Color.fromARGB(255, 220, 220, 220),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: const Color.fromARGB(255, 204, 204, 204),
        ),
      ),
      title: Row(
        children: [
          Icon(Icons.category_outlined),
          SizedBox(width: 10),
          Text(AppLocalizations.of(context)!.app_category),
        ],
      ),
      children: categoryProvider.categories.map((category) {
        bool isSelected = productProvider.selectedCategories.contains(category.name);
        
        return ListTile(
          contentPadding: EdgeInsets.only(left: 40),
          tileColor: const Color.fromARGB(255, 242, 242, 242),
          selected: isSelected,
          selectedTileColor: const Color.fromRGBO(33, 150, 243, 0.2),
          title: Row(
            children: [
              Icon(
                isSelected ? Icons.check_box : Icons.check_box_outline_blank,
                size: 16,
                color: isSelected ? Colors.blue : Colors.grey,
              ),
              SizedBox(width: 10),
              Text(_getCategoryName(category.name)),
            ],
          ),
          onTap: () {
            productProvider.toggleCategoryFilter(category.name);
          },
        );
      }).toList(),
    );
  }

  String _getCategoryName(String name) {
    switch (name) {
      case 'ram':
        return AppLocalizations.of(context)!.app_drawer_category_ram;
      case 'cpu':
        return AppLocalizations.of(context)!.app_drawer_category_cpu;
      case 'gpu':
        return AppLocalizations.of(context)!.app_drawer_category_gpu;
      case 'motherboard':
        return AppLocalizations.of(context)!.app_drawer_category_motherboard;
      case 'storage':
        return AppLocalizations.of(context)!.app_drawer_category_storage;
      case 'psu':
        return AppLocalizations.of(context)!.app_drawer_category_psu;
      case 'cooler':
        return AppLocalizations.of(context)!.app_drawer_category_cooler;
      case 'display':
        return AppLocalizations.of(context)!.app_drawer_category_display;
      case 'case':
        return AppLocalizations.of(context)!.app_drawer_category_case;
      case 'keyboard':
        return AppLocalizations.of(context)!.app_drawer_category_keyboard;
      case 'mouse':
        return AppLocalizations.of(context)!.app_drawer_category_mouse;
      default:
        return name;
    }
  }
}