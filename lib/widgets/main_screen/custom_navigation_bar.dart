// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const CustomNavigationBar({super.key, required this.selectedIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: Color.fromARGB(255, 229, 229, 229), width: 3),
          ),
        ),
        child: NavigationBar(
          backgroundColor: Colors.white,
          elevation: 20,
          selectedIndex: selectedIndex,
          onDestinationSelected: onTap,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.star_border_outlined),
              label: 'Spotlight'
            ),
            NavigationDestination(
              icon: Icon(Icons.shopping_bag_outlined),
              label: 'Catalog'
            ),
            NavigationDestination(
              icon: Icon(Icons.shopping_cart_outlined),
              label: 'Cart'
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              label: 'Profile'
            ),
          ],
        ));
  }
}