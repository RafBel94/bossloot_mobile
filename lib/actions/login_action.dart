// ignore_for_file: use_build_context_synchronously

import 'package:bossloot_mobile/providers/favorite_provider.dart';
import 'package:bossloot_mobile/providers/user_provider.dart';
import 'package:bossloot_mobile/screens/auth/verify_email_screen.dart';
import 'package:bossloot_mobile/screens/main_screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void loginAction(BuildContext context, String email, String password) async {
  final userProvider = context.read<UserProvider>();
  final favoriteProvider = context.read<FavoriteProvider>();

  await userProvider.loginUser(email, password);

  if (userProvider.errorMessage != "Please confirm your email before logging in." && userProvider.errorMessage != null) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(userProvider.errorMessage!)));
    return;
  } else {

    await userProvider.checkEmailVerification(email);
    
    if (userProvider.errorMessage != null) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const VerifyEmailScreen()));
      return;
    }
  }
  
  favoriteProvider.fetchFavorites(userProvider.currentUser!.id.toString());
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainScreen()));
}
