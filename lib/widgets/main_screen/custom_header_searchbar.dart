import 'package:flutter/material.dart';

class CustomHeaderSearchbar extends StatelessWidget {
  const CustomHeaderSearchbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header con logo
        Container(
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(63, 0, 0, 0),
                offset: const Offset(0, 3),
                blurRadius: 6,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/bossloot-logo-margin.png',
                height: 35,
              ),
              const SizedBox(width: 8),
              Image.asset(
                'assets/images/bossloot-title-only.png',
                height: 20,
              ),
            ],
          ),
        ),
        
        // Barra de búsqueda
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
          child: Material(
            elevation: 2,
            borderRadius: BorderRadius.circular(10),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search in the catalogue...',
                prefixIcon: const Icon(Icons.search, size: 25),
                prefixIconConstraints: const BoxConstraints(
                  minWidth: 30,
                  minHeight: 30,
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 8, 
                  horizontal: 10,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}