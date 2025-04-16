import 'package:flutter/material.dart';

class CustomHeaderSearchbar extends StatefulWidget {
  const CustomHeaderSearchbar({super.key});

  @override
  State<CustomHeaderSearchbar> createState() => _CustomHeaderSearchbarState();
}

class _CustomHeaderSearchbarState extends State<CustomHeaderSearchbar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(blue: 255, green:255, red: 255, alpha: 0.2),
                offset: Offset(0, 3),
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
        
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(blue: 255, green:255, red: 255, alpha: 0.2),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search in the catalogue...',
                prefixIcon: const Icon(Icons.search, size: 25,),
                prefixIconConstraints: const BoxConstraints(
                  minWidth: 30,
                  minHeight: 30,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}