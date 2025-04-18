import 'package:flutter/material.dart';

class DrawerClearButton extends StatelessWidget {
  const DrawerClearButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Handle clear button press
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.white, width: 2),
          borderRadius: BorderRadius.circular(10)
        ),
        backgroundColor: const Color.fromARGB(255, 215, 215, 215),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
      ),
      child: const Text("Clear", style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 48, 48, 48), fontWeight: FontWeight.bold)),
    );
  }
}