import 'package:bossloot_mobile/providers/category_provider.dart';
import 'package:bossloot_mobile/providers/product_provider.dart';
import 'package:bossloot_mobile/screens/loading_screen/loading_screen.dart';
import 'package:bossloot_mobile/screens/main_screen/cart_screen/cart_screen.dart';
import 'package:bossloot_mobile/screens/main_screen/catalog_screen/catalog_screen.dart';
import 'package:bossloot_mobile/screens/main_screen/custom_drawer/custom_end_drawer.dart';
import 'package:bossloot_mobile/screens/main_screen/home_screen/home_screen.dart';
import 'package:bossloot_mobile/screens/main_screen/product_details_screen/product_details_screen.dart';
import 'package:bossloot_mobile/screens/main_screen/profile_screen/profile_screen.dart';
import 'package:bossloot_mobile/screens/main_screen/spotlight_screen/spotlight_screen.dart';
import 'package:bossloot_mobile/widgets/main_screen/custom_header_searchbar.dart';
import 'package:bossloot_mobile/widgets/main_screen/custom_navigation_bar.dart';
import 'package:bossloot_mobile/widgets/main_screen/filter_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int _selectedIndex = 2;
  bool _showingProductDetails = false;
  int _currentProductId = 0;
  bool _isLoading = true;
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

    _initializeAllProductsAndCategories();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  Future<void> _initializeAllProductsAndCategories() async {
    final startTime = DateTime.now();
    
    final categoryProvider = context.read<CategoryProvider>();
    final productProvider = context.read<ProductProvider>();
    await productProvider.fetchCatalogProducts();
    await productProvider.fetchFeaturedProducts();
    await categoryProvider.fetchCategories();


    if (mounted) {
      final elapsed = DateTime.now().difference(startTime);
      final remaining = Duration(seconds: 3) - elapsed;
      
      if (remaining > Duration.zero) {
        await Future.delayed(remaining);
      }
      
      setState(() {
        _isLoading = false;
      });
    }
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
          body: _isLoading 
        ? LoadingScreen()
        : Stack(
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
                      
                        if(_selectedIndex == 0 || _selectedIndex == 1)
                          FilterButton(scaffoldKey: _scaffoldKey),

                        if (_showingProductDetails && (_selectedIndex == 0 || _selectedIndex == 1 || _selectedIndex == 2))
                          ProductDetailsScreen(productId: _currentProductId, onBackPressed: hideProductDetails),
                      ]
                    ),
                  ),
                ],
              ),
            ],
          ),   

          // ------- Custom EndDrawer
          endDrawer: (_selectedIndex == 0 || _selectedIndex == 1) && !_showingProductDetails  ? CustomEndDrawer() : null,
        
          // ------- Custom Navigation Bar
          bottomNavigationBar: _isLoading || _showingProductDetails ? null: CustomNavigationBar(selectedIndex: _selectedIndex, onTap: _onNavigationBarTapped,)
        ),
      ),
    );
  }

  void _onNavigationBarTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  void showProductDetails(int productId) {
    setState(() {
      _currentProductId = productId;
      
      if (!_showingProductDetails) {
        _showingProductDetails = true;
      }
    });
  }

  void hideProductDetails() {
    setState(() {
      _showingProductDetails = false;
    });
  }
}
