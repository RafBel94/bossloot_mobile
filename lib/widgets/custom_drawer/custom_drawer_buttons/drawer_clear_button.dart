import 'package:bossloot_mobile/providers/product_provider.dart';
import 'package:bossloot_mobile/widgets/shared/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class DrawerClearButton extends StatelessWidget {
  const DrawerClearButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      text: AppLocalizations.of(context)!.app_clear,
      onPressed: () {
        // Limpiar todos los filtros
        final productProvider = Provider.of<ProductProvider>(context, listen: false);
        productProvider.clearFilters();
      },
    );
  }
}