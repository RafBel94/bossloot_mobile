// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'dart:ui';
import 'package:bossloot_mobile/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileButton extends StatelessWidget {
  final UserProvider userProvider;
  final String text;
  final String svgIconPath;
  final VoidCallback onPressed;

  const ProfileButton({
    super.key,
    required this.text,
    required this.svgIconPath,
    required this.userProvider,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final bool userLoggedIn = userProvider.currentUser != null;
    
    return GestureDetector(
      onTap: () {
        if (userLoggedIn || text == AppLocalizations.of(context)!.profile_screen_settings_button || text == AppLocalizations.of(context)!.profile_screen_contact_button) {
          onPressed();
        } else {
          null;
        }
      },
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: const Color.fromARGB(78, 77, 16, 112)),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(142, 119, 24, 173),
              blurRadius: 3,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Row(
                children: [
                  ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        colors: const [
                          Color(0xFF7B1FA2),
                          Color(0xFF673AB7),
                          Color(0xFFE91E63),
                          Color(0xFFF57F17),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ).createShader(bounds);
                    },
                    blendMode: BlendMode.srcATop,
                    child: SvgPicture.asset(
                      svgIconPath,
                      width: 60,
                      height: 60,
                    ),
                  ),

                  const SizedBox(width: 20),

                  Text( text, style: GoogleFonts.orbitron( color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600, ), ),
                ],
              ),
            ),

            // BLUR EFFECT
            if (!userLoggedIn && text != AppLocalizations.of(context)!.profile_screen_settings_button && text != AppLocalizations.of(context)!.profile_screen_contact_button)
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(168, 229, 217, 254),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon( Icons.lock_outline, color: Colors.black87, size: 32, ),

                          SizedBox(height: 5),

                          Text(AppLocalizations.of(context)!.profile_screen_locked_feature, textAlign: TextAlign.center, style: GoogleFonts.orbitron( fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87, ), ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
