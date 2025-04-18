import 'package:bossloot_mobile/screens/main_screen/cart_screen/cart_screen.dart';
import 'package:bossloot_mobile/screens/main_screen/catalog_screen/catalog_screen.dart';
import 'package:bossloot_mobile/screens/main_screen/custom_drawer/custom_end_drawer.dart';
import 'package:bossloot_mobile/screens/main_screen/product_details_screen/product_details_screen.dart';
import 'package:bossloot_mobile/screens/main_screen/profile_screen/profile_screen.dart';
import 'package:bossloot_mobile/screens/main_screen/spotlight_screen/spotlight_screen.dart';
import 'package:bossloot_mobile/utils/dialog_util.dart';
import 'package:bossloot_mobile/widgets/main_screen/custom_header_searchbar.dart';
import 'package:bossloot_mobile/widgets/main_screen/custom_navigation_bar.dart';
import 'package:bossloot_mobile/widgets/main_screen/filter_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  bool _showingProductDetails = false;
  int _currentProductId = 0;
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
    CartScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {


    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (_showingProductDetails) {
        hideProductDetails();
      } else {
        DialogUtil.showLogoutDialog(context);
      }
      },
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          body: Stack(
            children: [
              Column(
                children: [
                  // Search bar
                  const CustomHeaderSearchbar(),
                      
                  // PageView
                  Expanded(
                    child: Stack(
                      children: [
                        PageView(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: _pageController,
                          children: _screens,
                        ),
                      
                        
                        FilterButton(scaffoldKey: _scaffoldKey),

                        if (_showingProductDetails)
                        ProductDetailsScreen(productId: _currentProductId, onBackPressed: hideProductDetails),
                      ]
                    ),
                  ),
                ],
              ),
            ],
          ),   
          // ------- Custom EndDrawer
          endDrawer: CustomEndDrawer(),
          onEndDrawerChanged: (isOpened) {
            if (isOpened) {
              FocusManager.instance.primaryFocus?.unfocus();
            }
          },
        
          // ------- Custom Navigation Bar
          bottomNavigationBar: CustomNavigationBar(selectedIndex: _selectedIndex, onTap: _onNavigationBarTapped,)
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

  void showProductDetails(int productId) {
    setState(() {
      _showingProductDetails = true;
      _currentProductId = productId;
    });
  }

  void hideProductDetails() {
  setState(() {
    _showingProductDetails = false;
  });
}
}
