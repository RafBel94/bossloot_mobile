import 'package:bossloot_mobile/domain/models/valoration.dart';
import 'package:flutter/material.dart';

class ProductValorations extends StatelessWidget {

  final List<Valoration> valorations;

  const ProductValorations({super.key, required this.valorations});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color.fromARGB(255, 227, 210, 251), width: 1),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(51, 115, 23, 168),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          width: double.infinity,
          height: 45,
          child: Text('Loot ratings', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        ),

        const SizedBox(height: 10),

        // Valorations list
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color.fromARGB(255, 227, 210, 251), width: 1),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(51, 115, 23, 168),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          width: double.infinity,
          height: 45,
          child: Container(
            child: Image.network(valorations[1].user.profilePicture),
          ),
        ),
      ],
    );
  }
}
