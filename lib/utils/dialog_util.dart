import 'package:bossloot_mobile/providers/user_provider.dart';
import 'package:bossloot_mobile/screens/main_screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DialogUtil {
  static Future<dynamic> showLogoutDialog(BuildContext context, UserProvider userProvider) {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Color(0xFF2A0E4D),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.purpleAccent,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color.fromRGBO(156, 39, 176, 0.5),
                blurRadius: 10,
                spreadRadius: 3,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Title
              Text(
                "LOGOUT",
                style: GoogleFonts.pressStart2p(
                  fontSize: 18,
                  color: Colors.amber,
                  shadows: [
                    Shadow(
                      color: Colors.purple,
                      offset: Offset(2, 2),
                      blurRadius: 0,
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 25),
              
              // General Information
              _buildInfoSection(
                title: "You're about to log out!",
                content: "Do you really want to log out of your account?\n"
                        "You will need to log in again to access your account.",
                color: Colors.pinkAccent,
              ),
              
              SizedBox(height: 20),
              
              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Yes Button
                  ElevatedButton(
                    onPressed: () {
                      userProvider.logoutUser();
                      Navigator.pop(context);
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) => MainScreen(),
                      ));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(color: Colors.white, width: 2),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    ),
                    child: Text(
                      "Yes",
                      style: GoogleFonts.pressStart2p(
                        fontSize: 12,
                        letterSpacing: 1,
                      ),
                    ),
                  ),

                  // No Button
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(color: Colors.white, width: 2),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    ),
                    child: Text(
                      "No",
                      style: GoogleFonts.pressStart2p(
                        fontSize: 12,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  static void showProductImageDialog(BuildContext context, String imageUrl) {
    showGeneralDialog(
      context: context,
      barrierColor: const Color.fromRGBO(0, 0, 0, 0.7),
      transitionDuration: const Duration(milliseconds: 400),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
          ),
          child: ScaleTransition(
            scale: CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            ),
            child: child,
          ),
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return SafeArea(
          child: Center(
            child: Material(
              type: MaterialType.transparency,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.95,
                height: MediaQuery.of(context).size.height * 0.90,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromRGBO(0, 0, 0, 0.2),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Stack(
                  children: [
          
                    
                    InteractiveViewer(
                      panEnabled: true,
                      boundaryMargin: EdgeInsets.all(20),
                      minScale: 1,
                      maxScale: 3,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: NetworkImage(imageUrl),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
          
          
                    Positioned(
                      top: 10,
                      right: 10,
                      child: IconButton(
                        icon: const Icon(Icons.close, color: Colors.black),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
          
          
                    Positioned(
                      bottom: 10,
                      left: 10,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(0, 0, 0, 0.5),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.pinch, color: Colors.white, size: 18),
                            SizedBox(width: 6),
                            Text(
                              'Pinch to zoom',
                              style: TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static Future<dynamic> showUserProfileGuideDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Color(0xFF2A0E4D),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.purpleAccent,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color.fromRGBO(156, 39, 176, 0.5),
                blurRadius: 10,
                spreadRadius: 3,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Title
              Text(
                "USER PROFILE",
                style: GoogleFonts.pressStart2p(
                  fontSize: 18,
                  color: Colors.amber,
                  shadows: [
                    Shadow(
                      color: Colors.purple,
                      offset: Offset(2, 2),
                      blurRadius: 0,
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 25),
              
              // General Information
              _buildInfoSection(
                icon: Icons.person,
                title: "YOUR PROFILE",
                content: "Here you can edit your personal information and profile image",
                color: Colors.pinkAccent,
              ),
              
              SizedBox(height: 20),
              
              // Level and experience points
              _buildInfoSection(
                icon: Icons.star,
                title: "LEVEL SYSTEM",
                content: "• Your level unlocks special discounts\n"
                        "• Earn XP by purchasing products\n"
                        "• The max level is 3",
                color: Colors.lightBlueAccent,
              ),
              
              SizedBox(height: 20),
              
              // Button
              Center(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: Colors.white, width: 2),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  ),
                  child: Text(
                    "GOT IT!",
                    style: GoogleFonts.pressStart2p(
                      fontSize: 12,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Future<dynamic> showLoginRequiredDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Color(0xFF2A0E4D),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.purpleAccent,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color.fromRGBO(156, 39, 176, 0.5),
                blurRadius: 10,
                spreadRadius: 3,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Title
              Text(
                "LOGIN REQUIRED",
                style: GoogleFonts.pressStart2p(
                  fontSize: 18,
                  color: Colors.amber,
                  shadows: [
                    Shadow(
                      color: Colors.purple,
                      offset: Offset(2, 2),
                      blurRadius: 0,
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 25),
              
              // General Information
              _buildInfoSection(
                title: "Looks like you are not logged in",
                content: "Please log into your account to access this feature",
                color: Colors.pinkAccent,
              ),
              
              SizedBox(height: 20),
              
              // Button
              Center(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: Colors.white, width: 2),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  ),
                  child: Text(
                    "GOT IT!",
                    style: GoogleFonts.pressStart2p(
                      fontSize: 12,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Info Section Widget for the dialogs
Widget _buildInfoSection({
  IconData? icon,
  required String title,
  required String content,
  required Color color,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Title with icon if icon is provided
      if (icon != null) ...[
        Row(
          children: [
            Icon(icon, color: color, size: 20),
            SizedBox(width: 8),
            Text(
              title,
              style: GoogleFonts.pressStart2p(
                fontSize: 12,
                color: color,
              ),
            ),
          ],
        ),
      ],

      // Title without icon
      if (icon == null)
        Text(
          title,
          style: GoogleFonts.pressStart2p(
            fontSize: 12,
            color: color,
          ),
      ),
      
      SizedBox(height: 6),

      Text(
        content,
        style: TextStyle(
          color: Colors.white70,
          fontSize: 14,
          height: 1.4,
        ),
      ),
    ],
  );
}