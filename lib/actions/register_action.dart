// ignore_for_file: use_build_context_synchronously

import 'package:bossloot_mobile/providers/user_provider.dart';
import 'package:bossloot_mobile/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void registerAction(BuildContext context, String name, String email, String password, String repeatPassword) async {
  final userProvider = context.read<UserProvider>();

  await userProvider.registerUser(name, email, password, repeatPassword);

  if (userProvider.errorMessage != null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(userProvider.errorMessage!)),
    );

    return;
  }

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text("Registration successful! Please verify your email.")),
  );
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
}