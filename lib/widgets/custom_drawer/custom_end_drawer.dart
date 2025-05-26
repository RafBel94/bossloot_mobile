import 'package:bossloot_mobile/widgets/custom_drawer/custom_drawer_buttons/drawer_apply_button.dart';
import 'package:bossloot_mobile/widgets/custom_drawer/custom_drawer_buttons/drawer_clear_button.dart';
import 'package:bossloot_mobile/widgets/custom_drawer/custom_expansion_tiles/brand_filter_expansion_tile.dart';
import 'package:bossloot_mobile/widgets/custom_drawer/custom_expansion_tiles/category_filter_expansion_tile.dart';
import 'package:bossloot_mobile/widgets/custom_drawer/custom_expansion_tiles/offer_filter_expansion_tile.dart';
import 'package:bossloot_mobile/widgets/custom_drawer/custom_expansion_tiles/price_filter_expansion_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomEndDrawer extends StatefulWidget {
  const CustomEndDrawer({super.key});

  @override
  State<CustomEndDrawer> createState() => _CustomEndDrawerState();
}

class _CustomEndDrawerState extends State<CustomEndDrawer> {

  @override
  void initState() {
    super.initState();
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
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
  
          // HEADER (LOGO, TITLE AND SEARCH BAR)
          SizedBox(
            height: 90,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(color: Color.fromARGB(255, 208, 208, 208), width: 2.0, style: BorderStyle.solid),
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(51, 115, 23, 168),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(AppLocalizations.of(context)!.drawer_title, style: GoogleFonts.orbitron(fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 74, 74, 74), fontSize: 28),),
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
                  CategoryFilterExpansionTile(),
              
                  // BRAND FILTER
                  BrandFilterExpansionTile(),
              
                  // PRICE FILTER
                  PriceFilterExpansionTile(),

                  // OFFERS FILTER
                  OfferFilterExpansionTile(),
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
                  color: Color.fromARGB(51, 115, 23, 168),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, -3),
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