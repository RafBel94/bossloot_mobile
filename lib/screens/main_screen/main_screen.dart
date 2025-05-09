// ignore_for_file: use_build_context_synchronously

import 'package:bossloot_mobile/screens/main_screen/cart_screen/cart_screen.dart';
import 'package:bossloot_mobile/screens/main_screen/catalog_screen/catalog_screen.dart';
import 'package:bossloot_mobile/widgets/custom_drawer/custom_end_drawer.dart';
import 'package:bossloot_mobile/screens/main_screen/home_screen/home_screen.dart';
import 'package:bossloot_mobile/screens/main_screen/profile_screen/profile_screen.dart';
import 'package:bossloot_mobile/screens/main_screen/spotlight_screen/spotlight_screen.dart';
import 'package:bossloot_mobile/widgets/main_screen/custom_header_searchbar.dart';
import 'package:bossloot_mobile/widgets/main_screen/custom_navigation_bar.dart';
import 'package:bossloot_mobile/widgets/main_screen/filter_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainScreen extends StatefulWidget {
  final int? withPageIndex;
  const MainScreen({super.key, this.withPageIndex});

  @override
  State<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int _selectedIndex = 2;
  bool _showingProductDetails = false;
  late PageController _pageController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.black
      ),
    );

    if (widget.withPageIndex != null) {
      _selectedIndex = widget.withPageIndex!;
    }

    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final List<Widget> _screens = [
    SpotlightScreen(),
    CatalogScreen(),
    HomeScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (_showingProductDetails) {
          hideProductDetails();
        }
      },
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          body: Stack(
            children: [
              Column(
                children: [
                  // PageView
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 75),
                      child: Stack(
                        children: [
                          PageView(
                            physics: const NeverScrollableScrollPhysics(),
                            controller: _pageController,
                            children: _screens,
                          ),
                        
                          if(_selectedIndex == 0 || _selectedIndex == 1)
                            FilterButton(scaffoldKey: _scaffoldKey),
                        ]
                      ),
                    ),
                  ),
                ],
              ),

              // Search bar
              const CustomHeaderSearchbar(),
            ],
          ),   

          // ------- Custom EndDrawer
          endDrawer: (_selectedIndex == 0 || _selectedIndex == 1) ? CustomEndDrawer() : null,
        
          // ------- Custom Navigation Bar
          bottomNavigationBar: CustomNavigationBar(selectedIndex: _selectedIndex, onTap: _onNavigationBarTapped)
        ),
      ),
    );
  }

  void _onNavigationBarTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  void hideProductDetails() {
    setState(() {
      _showingProductDetails = false;
    });
  }
}