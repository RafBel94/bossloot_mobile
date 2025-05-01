import 'package:bossloot_mobile/providers/product_provider.dart';
import 'package:bossloot_mobile/screens/loading_screen/data_loading_screen.dart';
import 'package:bossloot_mobile/screens/main_screen/product_details_screen/product_details/general_product_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int productId;
  final VoidCallback onBackPressed;

  ProductDetailsScreen({
    required this.productId, 
    required this.onBackPressed,
  }) : super(key: ValueKey(productId));

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  bool _isLoading = true;
  late ProductProvider productProvider;

  @override
  void initState() {
    super.initState();
    productProvider = context.read<ProductProvider>();
    _fetchProductDetails(widget.productId);
  }

  _fetchProductDetails(int productId) async {
    await productProvider.fetchProductDetails(productId);
    if(mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
    ? DataLoadingScreen()
    : Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background-image-workshop.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 80),
            child: GeneralProductDetails(product: productProvider.currentProductDetails),
          ),
        ),


        // Buttons to buy and add to cart
        bottomSheet: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          height: 70,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 255, 255),
            border: Border(
              top: BorderSide(color: Color.fromARGB(255, 229, 229, 229), width: 3),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple[800],
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  ),
                  onPressed: () {
                    // Add to cart logic
                  },
                  child: Text('Add to cart', style: TextStyle(color: Colors.white)),
                ),
              ),

              SizedBox(width: 16),

              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 131, 85, 255),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  ),
                  onPressed: () {
                    // Buy now logic
                  },
                  child: Text('Buy now', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      );
  }
}