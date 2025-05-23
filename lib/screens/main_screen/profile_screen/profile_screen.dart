// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:bossloot_mobile/domain/models/user.dart';
import 'package:bossloot_mobile/providers/user_provider.dart';
import 'package:bossloot_mobile/screens/auth/login_screen.dart';
import 'package:bossloot_mobile/screens/main_screen/orders_screen/orders_screen.dart';
import 'package:bossloot_mobile/screens/main_screen/profile_screen/settings_screen/contact_screen/contact_screen.dart';
import 'package:bossloot_mobile/screens/main_screen/profile_screen/settings_screen/favorite_screen/favorite_screen.dart';
import 'package:bossloot_mobile/screens/main_screen/profile_screen/profile_button.dart';
import 'package:bossloot_mobile/screens/main_screen/profile_screen/profile_details_screen/profile_details_screen.dart';
import 'package:bossloot_mobile/screens/main_screen/profile_screen/settings_screen/settings_screen.dart';
import 'package:bossloot_mobile/utils/dialog_util.dart';
import 'package:bossloot_mobile/utils/text_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late User? currentUser;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = context.watch<UserProvider>();
    currentUser = userProvider.currentUser;
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background-image-workshop.png'),
          fit: BoxFit.fill,
          repeat: ImageRepeat.repeat
        ),
      ),
      child: Stack(
        children: [

          // General Container
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 70, bottom: 15),
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color.fromARGB(150, 223, 64, 251),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromRGBO(156, 39, 176, 0.5),
                    blurRadius: 6,
                    spreadRadius: 3,
                  ),
                ],
              ),

              // Inside Container
              child: Padding(
                padding: const EdgeInsets.all(3),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(199, 194, 194, 194),
                    borderRadius: BorderRadius.circular(5),
                  ),

                  // Inside Content
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        // User Name and login / logout button
                        Material(
                          elevation: 5,
                          shadowColor: const Color.fromARGB(132, 115, 23, 168),
                          color: const Color.fromARGB(255, 245, 245, 245),
                          borderRadius: BorderRadius.circular(5),
                          surfaceTintColor: Colors.transparent,
                          child: Container(
                            padding: EdgeInsets.only(
                              top: currentUser == null ? 60 : 1,
                              bottom: 15,
                              right: 3,
                              left: 3,
                            ),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: const Color.fromARGB(147, 211, 211, 211),
                                  width: 2,
                                ),
                              )
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                            
                                // Log In Button
                                Align(
                                  alignment: currentUser != null ?  Alignment.centerRight : Alignment.center,
                                  child: LoginButton(user: currentUser, userProvider: userProvider,)
                                ),

                                if (currentUser != null)
                                const SizedBox(height: 10),
                            
                                // User Name
                                if (currentUser != null)
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: FittedBox(
                                    child: Text(
                                      currentUser!.name.split(' ').length > 1 ? '${currentUser!.name.split(' ')[0]} ${currentUser!.name.split(' ')[1]}' : currentUser!.name,
                                      style: GoogleFonts.orbitron(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 45, 45, 45),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),


                        const SizedBox(height: 10),

                        // Buttons
                        ProfileButtonsListView(userProvider: userProvider, currentUser: currentUser),
                        
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          // User Avatar
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color.fromARGB(150, 50, 20, 183),
                  width: 8,
                ),
              ),
              child: CircleAvatar(
                radius: 50,
                backgroundColor: const Color.fromARGB(255, 226, 226, 226),
                child: ClipOval(
                  child: currentUser != null 
                  ? Image.network(
                    currentUser!.profilePicture,
                    fit: BoxFit.cover,
                    width: 100,
                    height: 100,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const SizedBox(
                        width: 100,
                        height: 100,
                        child: Center(child: CircularProgressIndicator()),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.broken_image, size: 50);
                    },
                  )
                  : Image.asset(
                    'assets/images/avatar-placeholder.png',
                    fit: BoxFit.cover,
                    width: 100,
                    height: 100,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileButtonsListView extends StatelessWidget {
  const ProfileButtonsListView({
    super.key,
    required this.userProvider,
    required this.currentUser,
  });

  final UserProvider userProvider;
  final User? currentUser;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          padding: EdgeInsets.only(top: 5),
          children: [
            // Profile Button
            ProfileButton(
              text: AppLocalizations.of(context)!.profile_screen_profile_button, 
              svgIconPath: 'assets/icons/profile-icon.svg', 
              userProvider: userProvider, 
              onPressed: () => Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => const ProfileDetailsScreen())
              )
            ),
            
            const SizedBox(height: 9),
            
            // Orders Button
            ProfileButton(
              text: AppLocalizations.of(context)!.profile_screen_orders_button, 
              svgIconPath: 'assets/icons/orders-icon.svg', 
              userProvider: userProvider, 
              onPressed: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => const OrdersScreen())
                );
              },
            ),
            
            const SizedBox(height: 9),
            
            // Favorites Button
            ProfileButton(
              text: AppLocalizations.of(context)!.profile_screen_favorites_button, 
              svgIconPath: 'assets/icons/favorites-icon.svg', 
              userProvider: userProvider, 
              onPressed: () => Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => FavoriteScreen(user: currentUser))
              )
            ),
            
            const SizedBox(height: 9),
            
            // Contact Button
            ProfileButton(
              text: AppLocalizations.of(context)!.profile_screen_contact_button,
              svgIconPath: 'assets/icons/contact-icon.svg', 
              userProvider: userProvider, 
              onPressed: () => Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => ContactScreen())
              )
            ),

            const SizedBox(height: 9),

            // Settings Button
            ProfileButton(
              text: AppLocalizations.of(context)!.profile_screen_settings_button, 
              svgIconPath: 'assets/icons/settings-icon.svg', 
              userProvider: userProvider, 
              onPressed: () => Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => SettingsScreen(user: currentUser))
              )
            ),
            
            const SizedBox(height: 9),
            
          ],
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  User? user;
  UserProvider userProvider;

  LoginButton({
    super.key, required this.user, required this.userProvider,
  });

  @override
  Widget build(BuildContext context) {
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
        backgroundColor: const Color.fromARGB(255, 240, 231, 255),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: const BorderSide(
            color: Color.fromARGB(98, 100, 11, 151),
            width: 2,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.account_circle, color: const Color.fromARGB(255, 22, 22, 22), size: 20,),
          const SizedBox(width: 5),
          TextUtil(text: user == null ? 'Login' : 'Logout', size: 16, isBold: true,)
        ]
      ),
    );
  }
}