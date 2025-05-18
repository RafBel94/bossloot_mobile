// ignore_for_file: use_build_context_synchronously

import 'package:bossloot_mobile/providers/user_provider.dart';
import 'package:bossloot_mobile/screens/auth/login_screen.dart';
import 'package:bossloot_mobile/utils/dialog_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void registerAction(BuildContext context, String name, String email, String password, String repeatPassword) async {
  final userProvider = context.read<UserProvider>();

  await userProvider.registerUser(name, email, password, repeatPassword);

  if (userProvider.validationError != null) {
    if (userProvider.validationError == "The email has already been taken.") {
      DialogUtil.showValidationErrorDialog(context, null);
    } else {
      DialogUtil.showValidationErrorDialog(context, userProvider.validationError!);
    }
    return;
  } 
  else if (userProvider.errorMessage != null) {
    DialogUtil.showValidationErrorDialog(context, userProvider.errorMessage);
    return;
  }

  await DialogUtil.showRegistrationSuccessDialog(context);
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
}