// lib/screens/cart_screen.dart
// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class EmptyCartContainer extends StatelessWidget {
  const EmptyCartContainer({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 130),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background-image-goblin-shop-2.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: const Color.fromARGB(150, 223, 64, 251),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(151, 159, 78, 177),
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
        ),
    
        // Inside Container
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color.fromARGB(137, 255, 255, 255),
              borderRadius: BorderRadius.circular(5),
            ),
            // Inside Content
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                  Material(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(203, 255, 255, 255),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: const Color.fromARGB(152, 126, 16, 189),
                          width: 2,
                        ),
                      ),
                      child: Column(
                        children: [
    
                          // ICON
                          ShaderMask(
                            shaderCallback: (Rect bounds) {
                              return LinearGradient(
                                colors: const [
                                  Color(0xFF7B1FA2),
                                  Color.fromARGB(255, 121, 71, 206),
                                  Color(0xFFE91E63),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ).createShader(bounds);
                            },
                            blendMode: BlendMode.srcATop,
                            child: SvgPicture.asset(
                              'assets/icons/wagon-icon.svg',
                              width: 80,
                              height: 80,
                            ),
                          ),
      
                          SizedBox(height: 16),
                          Text(
                            AppLocalizations.of(context)!.cart_screen_empty_cart_label,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.orbitron(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 16),
                          // TEXT
                          Text(
                            AppLocalizations.of(context)!.cart_screen_empty_cart_text,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.orbitron(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 102, 102, 102),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
