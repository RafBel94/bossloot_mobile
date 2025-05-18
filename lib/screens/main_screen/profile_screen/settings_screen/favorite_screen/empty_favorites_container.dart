// lib/screens/cart_screen.dart
// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class EmptyFavoritesContainer extends StatelessWidget {
  const EmptyFavoritesContainer({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16),
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
                          'assets/icons/open-chest-icon.svg',
                          width: 80,
                          height: 80,
                        ),
                      ),
        
                      SizedBox(height: 16),
                      Text(
                        AppLocalizations.of(context)!.favorites_screen_empty_label,
                        style: GoogleFonts.orbitron(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        ),
                      ),
        
                      SizedBox(height: 16),
                      // TEXT
                      Text(
                        AppLocalizations.of(context)!.favorites_screen_empty_text,
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
    );
  }
}
