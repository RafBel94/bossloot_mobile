import 'package:flutter/material.dart';

class CustomHeaderSearchbar extends StatefulWidget {
  const CustomHeaderSearchbar({super.key});

  @override
  State<CustomHeaderSearchbar> createState() => _CustomHeaderSearchbarState();
}

class _CustomHeaderSearchbarState extends State<CustomHeaderSearchbar> 
    with SingleTickerProviderStateMixin {
  bool _isSearchExpanded = false;
  final FocusNode _searchFocusNode = FocusNode();
  late AnimationController _animationController;
  late Animation<double> _heightAnimation;
  late TextEditingController _searchBarController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _heightAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _searchBarController = TextEditingController();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchBarController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header
        Container(
          padding: const EdgeInsets.symmetric(vertical: 6),
          margin: _isSearchExpanded ? EdgeInsets.only(bottom: 3) : EdgeInsets.only(bottom: 1),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 190, 190, 190),
                blurRadius: 4.0,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/bossloot-logo-margin.png', height: 35),
              const SizedBox(width: 8),
              Image.asset('assets/images/bossloot-title-only.png', height: 20),
            ],
          ),
        ),

        // Search bar
        AnimatedBuilder(
          animation: _heightAnimation,
          builder: (context, child) {
            return ClipRect(
              child: Align(
                heightFactor: _heightAnimation.value,
                child: child,
              ),
            );
          },
          child: SizedBox(
            height: 50,
            child: Material(
              elevation: 2,
              color: Color.fromARGB(255, 242, 242, 242),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: TextField(
                  focusNode: _searchFocusNode,
                  onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                  controller: _searchBarController,
                  decoration: InputDecoration(
                    hintText: 'Search in the catalogue...',
                    prefixIcon: Icon(Icons.search, size: 24),
                    prefixIconConstraints: BoxConstraints(
                      minWidth: 30,
                      minHeight: 20,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear, size: 20),
                      onPressed: () {
                        _searchBarController.clear();
                      },
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: const Color.fromARGB(255, 216, 216, 216),
                        width: 1,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 8, 
                      horizontal: 10,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),

        // Expand/Collapse button
        Material(
          color: Colors.white,
          child: InkWell(
            onTap: _toggleSearch,
            child: Container(
              width: double.infinity,
              padding: _isSearchExpanded ?  null : EdgeInsets.symmetric(vertical: 3),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 231, 231, 231),
                border: Border(
                  top: BorderSide(
                    color: const Color.fromARGB(255, 190, 190, 190),
                    width: 1,
                  ),
                )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (!_isSearchExpanded)
                    Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: Text('Tap to open search bar',style: TextStyle(color: Colors.black,fontSize: 12,)),
                    ),
                  Icon(
                    _isSearchExpanded 
                        ? Icons.keyboard_arrow_up 
                        : Icons.keyboard_arrow_down,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ),

        
      ],
    );
  }

  void _toggleSearch() {
    setState(() {
      _isSearchExpanded = !_isSearchExpanded;
      _isSearchExpanded
          ? _animationController.forward()
          : _animationController.reverse();
    });
  }
}