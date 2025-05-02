// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'dart:ui';

import 'package:bossloot_mobile/domain/models/user.dart';
import 'package:bossloot_mobile/providers/user_provider.dart';
import 'package:bossloot_mobile/screens/auth/login_screen.dart';
import 'package:bossloot_mobile/screens/main_screen/main_screen.dart';
import 'package:bossloot_mobile/screens/main_screen/profile_screen/profile_details_screen/profile_details_screen.dart';
import 'package:bossloot_mobile/utils/text_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserProvider userProvider;
  late User? currentUser;

  @override
  void initState() {
    super.initState();
    userProvider = context.read<UserProvider>();
    currentUser = userProvider.currentUser;
  }

  @override
  Widget build(BuildContext context) {
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
                color: const Color.fromARGB(255, 234, 234, 234),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: const Color.fromARGB(146, 141, 100, 195),
                  width: 2,
                ),
              ),

              // Inside Container
              child: Padding(
                padding: const EdgeInsets.all(3),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(117, 237, 237, 237),
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: const Color.fromARGB(57, 58, 12, 84),
                      width: 2,
                    ),
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
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: FittedBox(
                                    child: Text(
                                      currentUser != null ? currentUser!.name : 'Anonymous',
                                      style: const TextStyle(
                                        fontSize: 25,
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


                        const SizedBox(height: 15),

                        // Buttons
                        Expanded(
                          child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                                
                              // Profile Button
                              CustomElevatedButton( text: 'Profile', svgIconPath: 'assets/icons/profile-icon.svg', userProvider: userProvider , onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileDetailsScreen(),))),
                            
                              const SizedBox(height: 10),
                            
                              // Orders Button
                              CustomElevatedButton( text: 'Orders', svgIconPath: 'assets/icons/orders-icon.svg', userProvider: userProvider , onPressed: () {}, ),
                            
                              const SizedBox(height: 10),
                            
                              // Favorites Button
                              CustomElevatedButton( text: 'Favorites', svgIconPath: 'assets/icons/favorites-icon.svg', userProvider: userProvider , onPressed:() {}, ),

                              const SizedBox(height: 10),
                              
                              // Settings Button
                              CustomElevatedButton( text: 'Settings', svgIconPath: 'assets/icons/settings-icon.svg', userProvider: userProvider , onPressed:() {}, ),

                            ],
                          ),
                          ),
                        )
                        
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
                  child: Image.network(
                    currentUser != null
                        ? currentUser!.profilePicture
                        : 'https://res.cloudinary.com/dlmbw4who/image/upload/v1742850142/avatar-placeholder_qiq5pb.png',
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

class CustomElevatedButton extends StatelessWidget {
  final UserProvider userProvider;
  final String text;
  final String svgIconPath;
  final VoidCallback onPressed;

  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.svgIconPath,
    required this.userProvider,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final bool userLoggedIn = userProvider.currentUser != null;
    
    return GestureDetector(
      onTap: userLoggedIn ? () => onPressed() : null,
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: const Color.fromARGB(78, 77, 16, 112)),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(142, 119, 24, 173),
              blurRadius: 3,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Row(
                children: [
                  ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        colors: const [
                          Color(0xFF7B1FA2),
                          Color(0xFF673AB7),
                          Color(0xFFE91E63),
                          Color(0xFFF57F17),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ).createShader(bounds);
                    },
                    blendMode: BlendMode.srcATop,
                    child: SvgPicture.asset(
                      svgIconPath,
                      width: 60,
                      height: 60,
                    ),
                  ),

                  const SizedBox(width: 20),

                  Text( text, style: const TextStyle( color: Colors.black, fontSize: 24, fontWeight: FontWeight.w500, ), ),
                ],
              ),
            ),

            // BLUR EFFECT
            if (!userLoggedIn && text != 'Settings')
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(168, 229, 217, 254),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon( Icons.lock_outline, color: Colors.black87, size: 32, ),

                          SizedBox(height: 5),

                          Text( 'Log In to access this feature!', textAlign: TextAlign.center, style: TextStyle( fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87, ), ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
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
          showDialog(context: context, builder: (context) {
            return AlertDialog(
              title: const Text('Log Out'),
              content: const Text('Are you sure you want to log out?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    await userProvider.logoutUser();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const MainScreen(),));
                  },
                  child: const Text('Log Out', style: TextStyle(),),
                ),
              ],
            );
          },);
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