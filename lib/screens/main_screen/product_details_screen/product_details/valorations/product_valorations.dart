import 'package:bossloot_mobile/domain/models/valoration.dart';
import 'package:bossloot_mobile/utils/dialog_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          child: FittedBox(child: Text(AppLocalizations.of(context)!.product_details_screen_valoration_label, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))),
        ),

        const SizedBox(height: 10),


        // Valorations list
        if (valorations.isNotEmpty)
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
          height: MediaQuery.of(context).size.height * 0.67,
          child: SizedBox(
            child: ListView.builder(
              itemCount: valorations.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 252, 252, 252),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color.fromARGB(255, 227, 210, 251), width: 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(bottom: 8, top: 3),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 252, 252, 252),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          border: Border(
                            bottom: BorderSide(
                              color: const Color.fromARGB(255, 227, 210, 251),
                              width: 1,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            // User profile picture and name
                            Expanded(
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(valorations[index].user.profilePicture),
                                    radius: 22,
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        valorations[index].user.name.split(' ').take(2).join(' '),
                                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                      FittedBox(
                                        child: Text(
                                          '${AppLocalizations.of(context)!.app_adventurer_level} ${valorations[index].user.level}', 
                                          style: TextStyle(fontSize: 14, color: Colors.grey),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            
                            const SizedBox(width: 8),
                            
                            // Stars
                            Row(
                              children: List.generate(5, (starIndex) {
                                return Icon(
                                  starIndex < valorations[index].rating.round() ? Icons.star : Icons.star_border,
                                  color: starIndex < valorations[index].rating.round() ? Colors.amber : Colors.grey,
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Comment
                      Text(valorations[index].comment ?? '', style: TextStyle(fontSize: 14)),

                      const SizedBox(height: 5),

                      // Image
                      if(valorations[index].image != null)
                      GestureDetector(
                        onTap: () {
                          DialogUtil.showProductImageDialog(context, valorations[index].image!);
                        },
                        child: Container(
                          padding: const EdgeInsets.only(top: 5),
                          height: 150,
                          width: 150,
                          child: Image.network(valorations[index].image!),
                        ),
                      ),

                      const SizedBox(height: 5),

                      // Date
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(top: 8, bottom: 3),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 252, 252, 252),
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          border: Border(
                            top: BorderSide(
                              color: const Color.fromARGB(255, 227, 210, 251),
                              width: 1,
                            ),
                          ),
                        ),
                        child: Text('${AppLocalizations.of(context)!.app_created} ${valorations[index].createdAt.day}/${valorations[index].createdAt.month}/${valorations[index].createdAt.year}',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),


        // ---- MESSAGE IF NO VALORATIONS ----

        if (valorations.isEmpty)
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
          height: MediaQuery.of(context).size.height * 0.66,
          child: SizedBox(
            child: Text(AppLocalizations.of(context)!.product_details_screen_no_valorations, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold) ),
          ),
        ),
      ],
    );
  }
}
