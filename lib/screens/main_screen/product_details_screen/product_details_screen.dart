import 'package:bossloot_mobile/providers/product_provider.dart';
import 'package:bossloot_mobile/providers/user_provider.dart';
import 'package:bossloot_mobile/screens/loading_screen/data_loading_screen.dart';
import 'package:bossloot_mobile/screens/main_screen/main_screen.dart';
import 'package:bossloot_mobile/screens/main_screen/product_details_screen/product_details/general_product_details.dart';
import 'package:bossloot_mobile/utils/dialog_util.dart';
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

    UserProvider userProvider = context.read<UserProvider>();

    return _isLoading
    ? DataLoadingScreen()
    : SafeArea(
      child: Scaffold(
          body: Stack(
            children: [
              Container(
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

              // Botón de volver al catálogo
              Positioned(
                bottom: 80.0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => MainScreen(withPageIndex: 1,)),
                      (Route<dynamic> route) => false,
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 253, 253, 253),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                      border: Border(
                        left: BorderSide(color: const Color.fromARGB(255, 229, 229, 229), width: 3),
                        top: BorderSide(color: const Color.fromARGB(255, 229, 229, 229), width: 3),
                        bottom: BorderSide(color: const Color.fromARGB(255, 229, 229, 229), width: 3),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromRGBO(0, 0, 0, 0.5),
                          blurRadius: 4.0,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.shopping_bag_outlined,
                          color: const Color.fromARGB(255, 67, 8, 95),
                          size: 25,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Catalog',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 49, 49, 49),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
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
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
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
                      if (userProvider.currentUser == null) {
                        DialogUtil.showLoginRequiredDialog(context);
                        return;
                      }
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
                      if (userProvider.currentUser == null) {
                        DialogUtil.showLoginRequiredDialog(context);
                        return;
                      }
                    },
                    child: Text('Buy now', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}