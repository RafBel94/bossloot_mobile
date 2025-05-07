import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DrawerApplyButton extends StatelessWidget {
  const DrawerApplyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Handle apply button press
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.white, width: 2),
          borderRadius: BorderRadius.circular(10)
        ),
        backgroundColor: const Color.fromARGB(255, 248, 225, 254),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
      ),
      child: Text(AppLocalizations.of(context)!.app_apply, style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 48, 48, 48), fontWeight: FontWeight.bold)),
    );
  }
}