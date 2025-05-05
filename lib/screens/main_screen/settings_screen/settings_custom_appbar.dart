import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsCustomAppbar extends StatelessWidget {
  const SettingsCustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 30, 5, 40),
        border: Border(
          left: BorderSide(
            color: Color.fromARGB(255, 223, 64, 251),
            width: 1.0,
          ),
          right: BorderSide(
            color: Color.fromARGB(255, 223, 64, 251),
            width: 1.0,
          ),
          bottom: BorderSide(
            color: Color.fromARGB(255, 223, 64, 251),
            width: 1.0,
          ),
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16.0),
          bottomRight: Radius.circular(16.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 223, 64, 251),
            blurRadius: 6.0,
            spreadRadius: 0.5,
          ),
        ],
      ),
      child: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.settings_screen_title,
          style: GoogleFonts.pressStart2p(
            color: Colors.amber,
            shadows: const [
              Shadow(
                offset: Offset(2.5, 2.5),
                color: Color.fromARGB(255, 202, 10, 199),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        shadowColor: Colors.purpleAccent,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back, 
            size: 30, 
            color: Colors.amber, 
            shadows: [
              Shadow(
                offset: Offset(2.5, 2.5),
                blurRadius: 3.0,
                color: Color.fromARGB(255, 202, 10, 199),
              ),
            ],
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}