// ignore_for_file: type_literal_in_constant_pattern

import 'package:bossloot_mobile/domain/models/products/case_product.dart';
import 'package:bossloot_mobile/domain/models/products/cooler_product.dart';
import 'package:bossloot_mobile/domain/models/products/cpu_product.dart';
import 'package:bossloot_mobile/domain/models/products/display_product.dart';
import 'package:bossloot_mobile/domain/models/products/gpu_product.dart';
import 'package:bossloot_mobile/domain/models/products/keyboard_product.dart';
import 'package:bossloot_mobile/domain/models/products/motherboard_product.dart';
import 'package:bossloot_mobile/domain/models/products/mouse_product.dart';
import 'package:bossloot_mobile/domain/models/products/psu_product.dart';
import 'package:bossloot_mobile/domain/models/products/ram_product.dart';
import 'package:bossloot_mobile/domain/models/products/storage_product.dart';
import 'package:bossloot_mobile/screens/main_screen/product_details_screen/product_details/case_product_details.dart';
import 'package:bossloot_mobile/screens/main_screen/product_details_screen/product_details/cooler_product_details.dart';
import 'package:bossloot_mobile/screens/main_screen/product_details_screen/product_details/cpu_product_details.dart';
import 'package:bossloot_mobile/screens/main_screen/product_details_screen/product_details/display_product_details.dart';
import 'package:bossloot_mobile/screens/main_screen/product_details_screen/product_details/gpu_product_details.dart';
import 'package:bossloot_mobile/screens/main_screen/product_details_screen/product_details/keyboard_product_details.dart';
import 'package:bossloot_mobile/screens/main_screen/product_details_screen/product_details/motherboard_product_details.dart';
import 'package:bossloot_mobile/screens/main_screen/product_details_screen/product_details/mouse_product_details.dart';
import 'package:bossloot_mobile/screens/main_screen/product_details_screen/product_details/psu_product_details.dart';
import 'package:bossloot_mobile/screens/main_screen/product_details_screen/product_details/ram_product_details.dart';
import 'package:bossloot_mobile/screens/main_screen/product_details_screen/product_details/storage_product_details.dart';
import 'package:bossloot_mobile/utils/dialog_util.dart';
import 'package:flutter/material.dart';

class GeneralProductDetails extends StatelessWidget {
  final dynamic product;
  const GeneralProductDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    String formatedDiscount = product.discount % 1 == 0 
      ? product.discount.toStringAsFixed(0) 
      : product.discount.toString();
    String productPrice = (product.price - (product.price * (product.discount / 100))).toStringAsFixed(2);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
        child: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 245, 245, 245),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [

              // ---- Product Image
              Stack(
                children: [
                  GestureDetector(
                    onTap: () => DialogUtil.showProductImageDialog(context, product.image),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      height: 350,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(product.image),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color.fromARGB(137, 200, 200, 200), width: 1),
                      ),
                    ),
                  ),


                  // ---- Zoom In Button
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: IconButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.black54,
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                        padding: const EdgeInsets.all(10),
                      ),
                      icon: const Icon(Icons.zoom_in, color: Colors.white),
                      onPressed: () => DialogUtil.showProductImageDialog(context, product.image),
                    ),
                  ),
                ],
              ),
          
              SizedBox(height: 8),
      

              // ---- Product Name, Price and Valorations
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color.fromARGB(137, 200, 200, 200), width: 1),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    // ---- Product Price
                    Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      child: product.on_offer
                      ? Column(
                        mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(right: 10),
                              alignment: Alignment.topRight,
                              height: 15,
                              child: Text('${product.price}\$', style: const TextStyle(color: Color.fromARGB(255, 181, 181, 181), fontSize: 14.0, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis, decoration: TextDecoration.lineThrough)),
                            ),
                            Container(
                              padding: const EdgeInsets.only(right: 15),
                              alignment: Alignment.topRight,
                              height: 25,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(top: 5),
                                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                    alignment: Alignment.center,
                                    height: 20,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(255, 189, 48, 48),
                                      borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: Text('-$formatedDiscount%', style: const TextStyle(color: Colors.white, fontSize: 10.0, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis), textAlign: TextAlign.center),
                                  ),
                                  SizedBox(width: 5),
                                  Text('$productPrice\$', style: const TextStyle(color: Color.fromARGB(255, 198, 79, 79), fontSize: 23.0, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis))
                                ]
                              ),
                            ),
                            SizedBox(height: 8,),
                          ]
                        )
                      : Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Text('${product.price}\$', style: const TextStyle(fontSize: 23.0, color: Color.fromARGB(255, 63, 146, 66), fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis), textAlign: TextAlign.center,)
                        )
                      )
                    ),
      

                    // ---- Product Name
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        product.name,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    
                    SizedBox(height: 5),
              

                    // ---- Product valorations
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 2, right: 3),
                          child: Icon(Icons.star_half, color: const Color.fromARGB(255, 221, 204, 50), size: 24)),
                        Text('4.5  |  ', style: TextStyle(fontSize: 16, )),
                        Text('3 Valorations', style: TextStyle(fontSize: 13,)),
                      ],
                    ),
                  ],
                ),
              ),
      
              SizedBox(height: 8),


              // ---- Product Description
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color.fromARGB(137, 200, 200, 200), width: 1),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Description', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    SizedBox(height: 15),
                    Text(product.description, style: TextStyle(fontSize: 16),),
                  ],
                ),
              ),


              SizedBox(height: 8),


              // ---- Specifications
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color.fromARGB(137, 200, 200, 200), width: 1),
                ),
                child: _specificProductDetails(product),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _specificProductDetails(dynamic product) {
    switch (product.runtimeType) {
      case RamProduct:
        return RamProductDetails(product: product as RamProduct);      
      case GpuProduct:
        return GpuProductDetails(product: product as GpuProduct);
      case CpuProduct:
        return CpuProductDetails(product: product as CpuProduct);
      case StorageProduct:
        return StorageProductDetails(product: product as StorageProduct);
      case PsuProduct:
        return PsuProductDetails(product: product as PsuProduct);
      case CoolerProduct:
        return CoolerProductDetails(product: product as CoolerProduct);
      case CaseProduct:
        return CaseProductDetails(product: product as CaseProduct);
      case MotherboardProduct:
        return MotherboardProductDetails(product: product as MotherboardProduct);
      case DisplayProduct:
        return DisplayProductDetails(product: product as DisplayProduct);
      case KeyboardProduct:
        return KeyboardProductDetails(product: product as KeyboardProduct);
      case MouseProduct:
        return MouseProductDetails(product: product as MouseProduct);
      default:
        return const Text('Tipo de producto no soportado');
    }
  }
}