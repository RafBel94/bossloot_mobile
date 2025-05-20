import 'package:bossloot_mobile/domain/models/valoration.dart';
import 'package:bossloot_mobile/providers/user_provider.dart';
import 'package:bossloot_mobile/screens/main_screen/product_details_screen/product_details/valorations/add_valoration_screen.dart';
import 'package:bossloot_mobile/screens/main_screen/product_details_screen/product_details/valorations/valoration_container.dart';
import 'package:bossloot_mobile/utils/dialog_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProductValorations extends StatelessWidget {

  final List<Valoration> valorations;
  final int productId;

  const ProductValorations({super.key, required this.valorations, required this.productId});

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = context.read<UserProvider>();
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
                if (valorations[index].verified == true) {
                  return ValorationContainer(valoration: valorations[index], index: index);
                } else {
                  return SizedBox.shrink();
                }
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
      

      // ---- BUTTON TO ADD VALORATION ----
        const SizedBox(height: 10),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 5),
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
          child: ElevatedButton(
            onPressed: userProvider.currentUser != null
                ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddValorationScreen(productId: productId,),
                      ),
                    );
                  }
                : () {
                    DialogUtil.showLoginRequiredDialog(context);
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 105, 26, 158),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: Text(
              AppLocalizations.of(context)!.product_details_screen_valorations_button,
              style: GoogleFonts.orbitron(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
            ),
          )
        ),
      ],
    );
  }
}
