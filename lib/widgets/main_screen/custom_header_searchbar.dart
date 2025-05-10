import 'package:bossloot_mobile/domain/models/catalog_product.dart';
import 'package:bossloot_mobile/providers/product_provider.dart';
import 'package:bossloot_mobile/screens/main_screen/product_details_screen/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

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
  
  List<CatalogProduct> _suggestedProducts = [];
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();

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
    
    // Listener for the search bar text changes
    _searchBarController.addListener(_updateSuggestions);
    
    // Detect when the search bar loses focus
    _searchFocusNode.addListener(() {
      if (!_searchFocusNode.hasFocus) {
        _removeOverlay();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchBarController.dispose();
    _searchFocusNode.dispose();
    _removeOverlay();
    super.dispose();
  }

  void _updateSuggestions() {
    final ProductProvider productProvider = Provider.of<ProductProvider>(context, listen: false);
    final String query = _searchBarController.text.toLowerCase().trim();
    
    if (query.isEmpty) {
      if (_overlayEntry != null) {
        _removeOverlay();
      }
      return;
    }
    
    // Filter the product list based on the search query
    final filteredList = productProvider.catalogProductList
        .where((product) => product.name.toLowerCase().contains(query))
        .take(5)
        .toList();
    
    setState(() {
      _suggestedProducts = filteredList;
    });
    
    // Show or hide the overlay based on the filtered list
    if (filteredList.isNotEmpty) {
      _showSuggestionsOverlay();
    } else {
      _removeOverlay();
    }
  }
  
  void _showSuggestionsOverlay() {
    _removeOverlay();
    
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }
  
  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
  
  OverlayEntry _createOverlayEntry() {
    // Obtain the size of the search bar to position the overlay
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    
    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(-10.0, 42.0),
          child: Material(
            elevation: 4.0,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0),
            ),
            child: Container(
              height: _suggestedProducts.length * 50.0,
              width: size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                ),
              ),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: _suggestedProducts.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    dense: true,
                    title: Row(
                      children: [
                        Image.network(
                          _suggestedProducts[index].image,
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(width: 15),
                        FittedBox(fit: BoxFit.scaleDown, child: Text(_suggestedProducts[index].name, style: TextStyle(fontSize: 16))),
                      ],
                    ),
                    onTap: () {
                      _searchBarController.text = _suggestedProducts[index].name;
                      _removeOverlay();
                      FocusManager.instance.primaryFocus?.unfocus();
                      _toggleSearchSection();
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                        return ProductDetailsScreen(productId: _suggestedProducts[index].id, onBackPressed: () {},);
                      }));
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _toggleSearchSection() {
    setState(() {
      _isSearchExpanded = !_isSearchExpanded;
      _isSearchExpanded
          ? _animationController.forward()
          : _animationController.reverse();
    });
    
    if (!_isSearchExpanded) {
      _removeOverlay();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragEnd: (details) {
        if (details.velocity.pixelsPerSecond.dy < -300) {
          if (_isSearchExpanded) {
            _toggleSearchSection();
          }
        } else if (details.velocity.pixelsPerSecond.dy > 300) {
          if (!_isSearchExpanded) {
            _toggleSearchSection();
          }
        }
      },
      child: Column(
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
                  child: CompositedTransformTarget(
                    link: _layerLink,
                    child: TextField(
                      focusNode: _searchFocusNode,
                      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                      controller: _searchBarController,
                      decoration: searchFieldDecoration(context),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Expand/Collapse button with swipe gesture
          Material(
            color: Colors.white,
            child: InkWell(
              onTap: _toggleSearchSection,
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
                        child: Text(
                          AppLocalizations.of(context)!.app_searchbar_open,
                          style: TextStyle(color: const Color.fromARGB(255, 68, 68, 68), fontSize: 12, fontWeight: FontWeight.w600),
                        ),
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
      ),
    );
  }

  InputDecoration searchFieldDecoration(BuildContext context) {
    return InputDecoration(
      hintText: AppLocalizations.of(context)!.app_searchbar_field_hint,
      prefixIcon: Icon(Icons.search, size: 24),
      prefixIconConstraints: BoxConstraints(
        minWidth: 30,
        minHeight: 20,
      ),
      suffixIcon: IconButton(
        icon: Icon(Icons.clear, size: 20),
        onPressed: () {
          _searchBarController.clear();
          _removeOverlay();
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
    );
  }
}