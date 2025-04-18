import 'package:bossloot_mobile/domain/models/category.dart';
import 'package:bossloot_mobile/providers/category_provider.dart';
import 'package:bossloot_mobile/screens/main_screen/custom_drawer/custom_expansion_tiles/brand_filter_expansion_tile.dart';
import 'package:bossloot_mobile/screens/main_screen/custom_drawer/custom_expansion_tiles/category_filter_expansion_tile.dart';
import 'package:bossloot_mobile/screens/main_screen/custom_drawer/custom_expansion_tiles/date_filter_expansion_tile.dart';
import 'package:bossloot_mobile/screens/main_screen/custom_drawer/custom_drawer_buttons/drawer_apply_button.dart';
import 'package:bossloot_mobile/screens/main_screen/custom_drawer/custom_drawer_buttons/drawer_clear_button.dart';
import 'package:bossloot_mobile/screens/main_screen/custom_drawer/custom_expansion_tiles/price_filter_expansion_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomEndDrawer extends StatefulWidget {
  const CustomEndDrawer({super.key});

  @override
  State<CustomEndDrawer> createState() => _CustomEndDrawerState();
}

class _CustomEndDrawerState extends State<CustomEndDrawer> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeCategories();
  }
  Future<void> _initializeCategories() async {
    final categoryProvider = context.read<CategoryProvider>();
    await categoryProvider.fetchCategories();
    if(mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 250,
      elevation: 30,
      shadowColor: Colors.deepPurple,
      shape: const ContinuousRectangleBorder(
        side: BorderSide(color: Color.fromARGB(255, 144, 144, 144), width: 2.0, style: BorderStyle.solid),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(0),
          bottomLeft: Radius.circular(0),
        ),
      ),
      backgroundColor: Colors.white,
      child: _isLoading 
      ? const Center(child: CircularProgressIndicator())
      : Column(
        mainAxisSize: MainAxisSize.max,
        children: [
  
          // HEADER (LOGO, TITLE AND SEARCH BAR)
          SizedBox(
            height: 80,
            child: const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(color: Color.fromARGB(255, 208, 208, 208), width: 2.0, style: BorderStyle.solid),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 184, 184, 184),
                    blurRadius: 5.0,
                    spreadRadius: 1.0,
                    offset: Offset(0.0, 2.0),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.filter_alt, color: Colors.black, size: 30),
                  Text('Filters', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),),
                  SizedBox(width: 10),
                ],
              ),
            ),
          ),
          
          // FILTERS
          Expanded(
            child: SizedBox(
              height: double.infinity,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [      
                  // CATEGORY FILTER
                  CategoryFilterExpansionTile(categories: context.watch<CategoryProvider>().categories),
              
                  // BRAND FILTER
                  BrandFilterExpansionTile(),
              
                  // PRICE FILTER
                  PriceFilterExpansionTile(),
              
                  // DATE FILTER
                  DateFilterExpansionTile(),
                ],
              ),
            ),
          ),
  
          // BUTTONS
          Container(
            width: double.infinity,
            height: 80,
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Color.fromARGB(255, 208, 208, 208), width: 2.0, style: BorderStyle.solid),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 184, 184, 184),
                  blurRadius: 5.0,
                  spreadRadius: 1.0,
                  offset: Offset(0.0, -2.0),
                ),
              ]
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(width: 3,),

                // -------- APPLY BUTTON
                DrawerApplyButton(),

                const SizedBox(height: 10),

                // -------- CLEAR BUTTON
                DrawerClearButton(),

                const SizedBox(height: 10),
              ],
            ),
          )
        ],
      ),
    );
  }
}