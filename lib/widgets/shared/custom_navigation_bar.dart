// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomNavigationBar extends StatefulWidget {
  int selectedIndex;
  PageController pageController;

  CustomNavigationBar({super.key, required this.selectedIndex, required this.pageController});

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: Color.fromARGB(255, 215, 215, 215), width: 3),
          ),
        ),
        child: NavigationBar(
          elevation: 20,
          selectedIndex: widget.selectedIndex,
          onDestinationSelected: (int index) {
            setState(() {
              widget.selectedIndex = index;
            });
            widget.pageController.jumpToPage(index);
          },
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