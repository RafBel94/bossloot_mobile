// ignore_for_file: use_build_context_synchronously

import 'package:bossloot_mobile/providers/user_provider.dart';
import 'package:bossloot_mobile/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void resendVerificationAction(BuildContext context) async {
  final userProvider = context.read<UserProvider>();

  await userProvider.resendEmailVerification(userProvider.temporalUserEmail!);

  if (userProvider.errorMessage != null) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(userProvider.errorMessage!)));
    return;
  } 

  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Verification email resent!")));

  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
}
