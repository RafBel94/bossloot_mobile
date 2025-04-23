// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const CustomNavigationBar({super.key, required this.selectedIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 70,
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: Color.fromARGB(255, 136, 41, 107), width: 3),
          ),
        ),
        child: NavigationBar(
          backgroundColor: Colors.white,
          elevation: 20,
          selectedIndex: selectedIndex,
          onDestinationSelected: onTap,
          destinations: [

            // Spotlight
            NavigationDestination(
              icon: Icon(Icons.star_border_outlined),
              label: 'Spotlight'
            ),

            // Catalog
            NavigationDestination(
              icon: Icon(Icons.shopping_bag_outlined),
              label: 'Catalog'
            ),

            // Home
            NavigationDestination(
              icon: Container(
                height: 71,
                width: 71,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 82, 2, 135),
                      Color.fromARGB(255, 202, 37, 161),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(3),
                  child: Container(
                    height: 67,
                    width: 67,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 241, 241, 241),
                      shape: BoxShape.circle,
                      image: const DecorationImage(
                        image: AssetImage('assets/images/bossloot-logo-margin.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              label: '',
            ),

            // Cart
            NavigationDestination(
              icon: Icon(Icons.shopping_cart_outlined),
              label: 'Cart'
            ),

            // Profile
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              label: 'Profile'
            ),
          ],
        ));
  }
}