// lib/screens/cart_screen.dart
// ignore_for_file: library_private_types_in_public_api

import 'package:bossloot_mobile/domain/models/user.dart';
import 'package:bossloot_mobile/providers/user_provider.dart';
import 'package:bossloot_mobile/screens/auth/login_screen.dart';
import 'package:bossloot_mobile/utils/dialog_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginButton extends StatelessWidget {

  const LoginButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.read<UserProvider>();
    User? user = userProvider.currentUser;

    return ElevatedButton(
      onPressed: () {
        if (user != null) {
          DialogUtil.showLogoutDialog(context, userProvider);
        } else {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ));
        }
      },
      style: ElevatedButton.styleFrom(
        elevation: 4,
        backgroundColor: const Color.fromARGB(255, 249, 245, 255),
        fixedSize: const Size(200, 55),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: const BorderSide(
            color: Color.fromARGB(152, 126, 16, 189),
            width: 2,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      ),
      child: Text(user == null ? 'Login' : 'Logout',
        style: GoogleFonts.orbitron(
          fontSize: 22,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}