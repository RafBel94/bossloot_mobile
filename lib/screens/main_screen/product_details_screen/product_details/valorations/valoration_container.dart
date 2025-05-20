import 'package:bossloot_mobile/domain/models/valoration.dart';
import 'package:bossloot_mobile/utils/dialog_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ValorationContainer extends StatelessWidget {
  final int index;
  final Valoration valoration;
  const ValorationContainer({
    super.key,
    required this.valoration, required this.index,
  });


  @override
  Widget build(BuildContext context) {
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
                        backgroundImage: NetworkImage(valoration.user.profilePicture),
                        radius: 22,
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              valoration.user.name.split(' ').take(2).join(' '),
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              maxLines: 1,
                            ),
                          ),
                          FittedBox(
                            child: Text(
                              '${AppLocalizations.of(context)!.app_adventurer_level}${valoration.user.level}', 
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
                      starIndex < valoration.rating.round() ? Icons.star : Icons.star_border,
                      color: starIndex < valoration.rating.round() ? Colors.amber : Colors.grey,
                    );
                  }),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
    
          // Comment
          Text(valoration.comment ?? '', style: TextStyle(fontSize: 14)),
    
          const SizedBox(height: 5),
    
          // Image
          if(valoration.image != null)
          GestureDetector(
            onTap: () {
              DialogUtil.showProductImageDialog(context, valoration.image!);
            },
            child: Container(
              padding: const EdgeInsets.only(top: 5),
              height: 150,
              width: 150,
              child: Image.network(valoration.image!),
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
            child: Text('${AppLocalizations.of(context)!.app_created} ${valoration.createdAt.day}/${valoration.createdAt.month}/${valoration.createdAt.year}',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          )
        ],
      ),
    );
  }
}
