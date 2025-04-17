import 'package:bossloot_mobile/screens/main_screen/cart_screen/cart_screen.dart';
import 'package:bossloot_mobile/screens/main_screen/catalog_screen/catalog_screen.dart';
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
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
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
        DialogUtil.showLogoutDialog(context);
      },
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          body: Column(
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
        
                    FilterButton(scaffoldKey: _scaffoldKey,),
                  ]
                ),
              ),
            ],
          ),
        
          // ------- Custom Drawer
          endDrawer: Drawer(
            width: 250,
            elevation: 30,
            shadowColor: Colors.deepPurple,
            shape: const ContinuousRectangleBorder(
              side: BorderSide(color: Color.fromARGB(255, 144, 144, 144), width: 2.0, style: BorderStyle.solid),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(0),
                bottomLeft: Radius.circular(0),
              ),
            ),
            backgroundColor: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
        
                // HEADER
                SizedBox(
                  height: 80,
                  child: const DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(color: Color.fromARGB(255, 208, 208, 208), width: 2.0, style: BorderStyle.solid),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 184, 184, 184),
                          blurRadius: 5.0,
                          spreadRadius: 1.0,
                          offset: Offset(0.0, 2.0),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.filter_alt, color: Colors.black, size: 30),
                        Text('Filters', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),),
                        SizedBox(width: 10),
                      ],
                    ),
                  ),
                ),
                
                // FILTERS
                Expanded(
                  child: SizedBox(
                    height: double.infinity,
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [            
                        // FILTERS
                        // CATEGORY FILTER
                        ExpansionTile(
                          backgroundColor: const Color.fromARGB(255, 220, 220, 220),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: const Color.fromARGB(255, 204, 204, 204)
                            )
                          ),
                          title: Row(children: [Icon(Icons.category_outlined), SizedBox(width: 10), Text('Category')],),
                            children: [
                              ListTile(
                                contentPadding: EdgeInsets.only(left: 40),
                                tileColor: const Color.fromARGB(255, 242, 242, 242),
                                title: Row(children: [Icon(Icons.more_horiz_outlined), SizedBox(width: 10), Text('CPU')],),
                                onTap: () {
                                // Handle sub-item 1 tap
                                },
                              ),
                              ListTile(
                                contentPadding: EdgeInsets.only(left: 40),
                                tileColor: const Color.fromARGB(255, 242, 242, 242),
                                title: Row(children: [Icon(Icons.more_horiz_outlined), SizedBox(width: 10), Text('GPU')],),
                                onTap: () {
                                  // Handle sub-item 2 tap
                                },
                              ),
                            ],
                        ),
                    
                        // BRAND FILTER
                        ExpansionTile(
                          backgroundColor: const Color.fromARGB(255, 220, 220, 220),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: const Color.fromARGB(255, 204, 204, 204)
                            )
                          ),
                          title: Row(children: [Icon(Icons.copyright_outlined), SizedBox(width: 10), Text('Brand')],),
                            children: [
                              ListTile(
                                contentPadding: EdgeInsets.only(left: 40),
                                tileColor: const Color.fromARGB(255, 242, 242, 242),
                                title: Row(children: [Icon(Icons.more_horiz_outlined), SizedBox(width: 10), Text('AMD')],),
                                onTap: () {
                                  // Handle sub-item 1 tap
                                },
                              ),
                              ListTile(
                                contentPadding: EdgeInsets.only(left: 40),
                                tileColor: const Color.fromARGB(255, 242, 242, 242),
                                title: Row(children: [Icon(Icons.more_horiz_outlined), SizedBox(width: 10), Text('Corsair')],),
                                onTap: () {
                                  // Handle sub-item 2 tap
                                },
                              ),
                            ],
                        ),
                    
                        // PRICE FILTER
                        ExpansionTile(
                          backgroundColor: const Color.fromARGB(255, 220, 220, 220),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: const Color.fromARGB(255, 204, 204, 204)
                            )
                          ),
                          title: Row(children: [Icon(Icons.payments_outlined), SizedBox(width: 10), Text('Price')],),
                          children: [
                    
                            // MIN PRICE FILTER
                            ListTile(
                              contentPadding: EdgeInsets.only(left: 40),
                              tileColor: const Color.fromARGB(255, 242, 242, 242),
                              title: Row(
                                children: [
                                  Text('Min. Price: '),
                                  SizedBox(width: 5),
                                  Expanded(
                                    child: TextField(
                                    decoration: InputDecoration(
                                      constraints: BoxConstraints(
                                      maxWidth: 10,
                                      maxHeight: 40,
                                      ),
                                      border: OutlineInputBorder(),
                                      contentPadding: EdgeInsets.symmetric(horizontal: 5),
                                      filled: true,
                                      fillColor: Colors.white,
                                    ),
                                    keyboardType: TextInputType.number,
                                    ),
                                  ),
                    
                                  SizedBox(width: 30)
                                ],
                              ),
                            ),
                    
                            // MAX PRICE FILTER
                            ListTile(
                              contentPadding: EdgeInsets.only(left: 40),
                              tileColor: const Color.fromARGB(255, 242, 242, 242),
                              title: Row(
                                children: [
                                  Text('Max. Price: '),
                                  SizedBox(width: 5),
                                  Expanded(
                                    child: TextField(
                                    decoration: InputDecoration(
                                      constraints: BoxConstraints(
                                      maxWidth: 10,
                                      maxHeight: 40,
                                      ),
                                      border: OutlineInputBorder(),
                                      contentPadding: EdgeInsets.symmetric(horizontal: 5),
                                      filled: true,
                                      fillColor: Colors.white,
                                    ),
                                    keyboardType: TextInputType.number,
                                    ),
                                  ),
                    
                                  SizedBox(width: 30)
                                ],
                              ),
                            ),
                    
                          ],
                        ),
                    
                        // DATE FILTER
                        ExpansionTile(
                          backgroundColor: const Color.fromARGB(255, 220, 220, 220),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: const Color.fromARGB(255, 204, 204, 204)
                            )
                          ),
                          title: Row(children: [Icon(Icons.calendar_month), SizedBox(width: 10), Text('Date')],),
                            children: [
                              ListTile(
                                contentPadding: EdgeInsets.only(left: 40),
                                tileColor: const Color.fromARGB(255, 242, 242, 242),
                                title: Row(children: [Icon(Icons.arrow_upward), SizedBox(width: 10), Text('Ascendent')],),
                                onTap: () {
                                  // Handle sub-item 1 tap
                                },
                              ),
                              ListTile(
                                contentPadding: EdgeInsets.only(left: 40),
                                tileColor: const Color.fromARGB(255, 242, 242, 242),
                                title: Row(children: [Icon(Icons.arrow_downward), SizedBox(width: 10), Text('Descendent')],),
                                onTap: () {
                                  // Handle sub-item 2 tap
                                },
                              ),
                              ListTile(
                                contentPadding: EdgeInsets.only(left: 40),
                                tileColor: const Color.fromARGB(255, 242, 242, 242),
                                title: Row(
                                  children: [
                                    Text('From: '),
                                    SizedBox(width: 10),
                                    Expanded(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        side: BorderSide(color: Colors.white, width: 2),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: Text('Choose', style: TextStyle(color: Colors.black),),
                                      onPressed: () {}                          )
                                    ),
                                    SizedBox(width: 30,)
                                  ],
                                ),
                              ),
                              ListTile(
                                contentPadding: EdgeInsets.only(left: 40),
                                tileColor: const Color.fromARGB(255, 242, 242, 242),
                                title: Row(
                                  children: [
                                    Text('To: '),
                                    SizedBox(width: 30),
                                    Expanded(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        side: BorderSide(color: Colors.white, width: 2),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: Text('Choose', style: TextStyle(color: Colors.black),),
                                      onPressed: () {}                          )
                                    ),
                                    SizedBox(width: 30,)
                                  ],
                                ),
                              ),
                            ],
                        ),
                      ],
                    ),
                  ),
                ),
        
                // BUTTONS
                Container(
                  width: double.infinity,
                  height: 80,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(color: Color.fromARGB(255, 208, 208, 208), width: 2.0, style: BorderStyle.solid),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 184, 184, 184),
                        blurRadius: 5.0,
                        spreadRadius: 1.0,
                        offset: Offset(0.0, -2.0),
                      ),
                    ]
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(width: 3,),
                      ElevatedButton(
                        onPressed: () {
                          // Handle apply button press
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          backgroundColor: const Color.fromARGB(255, 248, 225, 254),
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                        ),
                        child: const Text("Apply", style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 48, 48, 48), fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
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
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                )
              ],
            ),
          ),
        
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
}
