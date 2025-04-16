import 'package:bossloot_mobile/utils/dialog_util.dart';
import 'package:bossloot_mobile/widgets/shared/custom_header_searchbar.dart';
import 'package:bossloot_mobile/widgets/shared/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  late PageController _pageController;

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
    Container(
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF270140),Color.fromARGB(255, 141, 24, 112)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            ),
          ),
    Container(
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/background-2.jpeg'), fit: BoxFit.fill)),
          ),
  ];

  @override
  Widget build(BuildContext context) {

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        DialogUtil.showLogoutDialog(context);
      },
      child: Scaffold(
        body: Column(
          children: [
            // Search bar
            SafeArea(child: const CustomHeaderSearchbar()),
      
            // PageView
            Expanded(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _pageController,
                children: _screens,
              ),
            ),
          ],
        ),
      
        bottomNavigationBar: CustomNavigationBar(selectedIndex: _selectedIndex, pageController: _pageController)
      ),
    );
  }
}
