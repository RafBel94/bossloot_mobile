import 'package:bossloot_mobile/domain/models/catalog_product.dart';
import 'package:bossloot_mobile/providers/product_provider.dart';
import 'package:bossloot_mobile/screens/main_screen/catalog_screen/catalog_product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<CatalogProduct> featuredProducts;
  late List<CatalogProduct> onOfferProducts;
  late List<CatalogProduct> randomProducts;
  late List<CatalogProduct> tempList;

  @override
  void initState() {
    super.initState();
    featuredProducts = context.read<ProductProvider>().featuredProductList;
    onOfferProducts = context.read<ProductProvider>().catalogProductList.where((product) => product.onOffer).toList()..shuffle();
    tempList = List.from(featuredProducts);
    randomProducts = (tempList..shuffle()).take(10).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/ladder-background.png'),
            fit: BoxFit.fill,
            repeat: ImageRepeat.repeat
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header with an asset image
              Stack(
                children: [
                Container(
                  width: double.infinity,
                  height: 400,
                  decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/gnome-greetings.png'),
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                  ),
                ),

                Positioned(
                  right: 20,
                  child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                    opacity: 0.85,
                    image: AssetImage('assets/images/welcome-boss.gif'),
                    ),
                  ),
                  ),
                ),

                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    height: 50,
                    alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(142, 255, 255, 255),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        border: Border.all(
                          color: const Color.fromARGB(255, 191, 191, 191),
                          width: 2,
                        ),
                      ),
                    child: Text(
                      'Our featured products',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ),
                ),
                ],
              ),

              // Featured Products Section
              Container(
                height: 320,
                margin: EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 233, 233, 233),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  border: Border.all(
                    color: const Color.fromARGB(255, 191, 191, 191),
                    width: 2,
                  ),
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  itemCount: featuredProducts.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromARGB(255, 225, 225, 225),
                          width: 2,
                        ),
                      ),
                      width: 200,
                      margin: EdgeInsets.only(right: 8),
                      child: CatalogProductCard(product: featuredProducts[index])
                    );
                  },
                ),
              ),

              SizedBox(height: 20),

              // On Offer Products Section
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                height: 50,
                alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(142, 255, 255, 255),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    border: Border.all(
                      color: const Color.fromARGB(255, 191, 191, 191),
                      width: 2,
                    ),
                  ),
                child: Text(
                  'Get these while they last!',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 0, 0, 0)),
                ),
              ),
              Container(
                height: 320,
                margin: EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 233, 233, 233),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  border: Border.all(
                    color: const Color.fromARGB(255, 191, 191, 191),
                    width: 2,
                  ),
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  itemCount: onOfferProducts.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromARGB(255, 225, 225, 225),
                          width: 2,
                        ),
                      ),
                      width: 200,
                      margin: EdgeInsets.only(right: 8),
                      child: CatalogProductCard(product: onOfferProducts[index])
                    );
                  },
                ),
              ),

              SizedBox(height: 20),

              // Recently Added Products Section
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                height: 50,
                alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(142, 255, 255, 255),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    border: Border.all(
                      color: const Color.fromARGB(255, 191, 191, 191),
                      width: 2,
                    ),
                  ),
                child: Text(
                  'The best of the best!',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 0, 0, 0)),
                ),
              ),
              Container(
                height: 320,
                margin: EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 233, 233, 233),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  border: Border.all(
                    color: const Color.fromARGB(255, 191, 191, 191),
                    width: 2,
                  ),
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  itemCount: randomProducts.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromARGB(255, 225, 225, 225),
                          width: 2,
                        ),
                      ),
                      width: 200,
                      margin: EdgeInsets.only(right: 8),
                      child: CatalogProductCard(product: randomProducts[index])
                    );
                  },
                ),
              ),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}