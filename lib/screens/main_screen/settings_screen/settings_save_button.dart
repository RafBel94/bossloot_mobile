import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsSaveButton extends StatelessWidget {
  const SettingsSaveButton({
    super.key,
    required String selectedLanguage,
    required String selectedCurrency,
  }) : _selectedLanguage = selectedLanguage, _selectedCurrency = selectedCurrency;

  final String _selectedLanguage;
  final String _selectedCurrency;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, right: 60, left: 60),
      height: 50,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 63, 8, 73),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: const Color.fromARGB(255, 223, 64, 251),
          width: 2,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(100, 223, 64, 251),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
      ),
      child: TextButton(
        onPressed: () {
          // TODO - Save settings logic
          // ignore: avoid_print
          print('Settings saved: Language: $_selectedLanguage, Currency: $_selectedCurrency');
        },
        child: Text(
          'SAVE',
          style: GoogleFonts.pressStart2p(
            color: Colors.amber,
            fontSize: 14,
            shadows: const [
              Shadow(
                offset: Offset(1.5, 1.5),
                color: Color.fromARGB(255, 202, 10, 199),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
