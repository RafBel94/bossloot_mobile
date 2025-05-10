// ignore_for_file: use_build_context_synchronously

import 'package:bossloot_mobile/providers/favorite_provider.dart';
import 'package:bossloot_mobile/providers/user_provider.dart';
import 'package:bossloot_mobile/screens/main_screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                AppLocalizations.of(context)!.logout_dialog_title,
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
                title: AppLocalizations.of(context)!.logout_dialog_subtitle,
                content: AppLocalizations.of(context)!.logout_dialog_text,
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
                      AppLocalizations.of(context)!.app_yes,
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
                              AppLocalizations.of(context)!.app_pinch_to_zoom,
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
                AppLocalizations.of(context)!.login_required_dialog_title,
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
                title: AppLocalizations.of(context)!.login_required_dialog_subtitle,
                content: AppLocalizations.of(context)!.login_required_dialog_text,
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
                    AppLocalizations.of(context)!.login_required_dialog_button,
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
                AppLocalizations.of(context)!.profile_details_help_dialog_title,
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
                title: AppLocalizations.of(context)!.profile_details_help_dialog_profile_label,
                content: AppLocalizations.of(context)!.profile_details_help_dialog_profile_text,
                color: Colors.pinkAccent,
              ),
              
              SizedBox(height: 20),
              
              // Level and experience points
              _buildInfoSection(
                icon: Icons.star,
                title: AppLocalizations.of(context)!.profile_details_help_dialog_level_label,
                content: AppLocalizations.of(context)!.profile_details_help_dialog_level_text,
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
                    AppLocalizations.of(context)!.profile_details_help_dialog_button,
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

  static Future<dynamic> showContactFormGuideDialog(BuildContext context) {
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
            Align(
              alignment: Alignment.center,
              child: Text(
                AppLocalizations.of(context)!.contact_screen_help_dialog_title,
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
            ),
            
            SizedBox(height: 25),
            
            // Contact Form Information
            _buildInfoSection(
              icon: Icons.contact_mail,
              title: AppLocalizations.of(context)!.contact_screen_help_dialog_form_label,
              content: AppLocalizations.of(context)!.contact_screen_help_dialog_form_text,
              color: Colors.pinkAccent,
            ),
            
            SizedBox(height: 20),
            
            // Response Time
            _buildInfoSection(
              icon: Icons.timer,
              title: AppLocalizations.of(context)!.contact_screen_help_dialog_response_label,
              content: AppLocalizations.of(context)!.contact_screen_help_dialog_response_text,
              color: Colors.greenAccent,
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
                  AppLocalizations.of(context)!.contact_screen_help_dialog_button,
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

  static Future<dynamic> showContactSuccessDialog(BuildContext context) {
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
              color: Colors.greenAccent,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color.fromRGBO(76, 175, 80, 0.5),
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
                AppLocalizations.of(context)!.contact_screen_success_dialog_title,
                style: GoogleFonts.pressStart2p(
                  fontSize: 18,
                  color: Colors.amber,
                  shadows: [
                    Shadow(
                      color: Colors.green,
                      offset: Offset(2, 2),
                      blurRadius: 0,
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 25),
              
              // General Information
              _buildInfoSection(
                title: AppLocalizations.of(context)!.contact_screen_success_dialog_subtitle,
                content: AppLocalizations.of(context)!.contact_screen_success_dialog_text,
                color: Colors.greenAccent,
              ),
              
              SizedBox(height: 20),
              
              // Button
              Center(
                child: ElevatedButton(
                  onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen(withPageIndex: 4,))),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: Colors.white, width: 2),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.contact_screen_success_dialog_button,
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

  static Future<dynamic> showContactErrorDialog(BuildContext context, {String? errorMessage}) {
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
              color: Colors.redAccent,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color.fromRGBO(244, 67, 54, 0.5),
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
                AppLocalizations.of(context)!.contact_screen_fail_dialog_title,
                style: GoogleFonts.pressStart2p(
                  fontSize: 18,
                  color: Colors.amber,
                  shadows: [
                    Shadow(
                      color: Colors.red,
                      offset: Offset(2, 2),
                      blurRadius: 0,
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 25),
              
              // General Information
              _buildInfoSection(
                title: AppLocalizations.of(context)!.contact_screen_fail_dialog_subtitle,
                content: errorMessage ?? AppLocalizations.of(context)!.contact_screen_fail_dialog_text,
                color: Colors.redAccent,
              ),
              
              SizedBox(height: 20),
              
              // Button
              Center(
                child: ElevatedButton(
                  onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen(withPageIndex: 4,))),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: Colors.white, width: 2),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.contact_screen_fail_dialog_button,
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

  static Future<dynamic> showFavoriteDialog(
    BuildContext context, 
    UserProvider userProvider, 
    FavoriteProvider favoriteProvider, 
    dynamic product, 
    bool isFavorite
  ) {
    bool isProcessing = false;
    
    return showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
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
                  FittedBox(
                    child: Text(
                      isFavorite ? AppLocalizations.of(context)!.favorite_remove_dialog_title : AppLocalizations.of(context)!.favorite_add_dialog_title,
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
                  ),
                  
                  SizedBox(height: 25),
                  
                  // General Information
                  _buildInfoSection(
                    icon: isFavorite ? Icons.heart_broken : Icons.favorite,
                    color: Colors.red,
                    title: isFavorite ? AppLocalizations.of(context)!.favorite_remove_dialog_text : AppLocalizations.of(context)!.favorite_add_dialog_text,
                    content: '',
                  ),
                  
                  SizedBox(height: 20),
                  
                  // Buttons
                  Row(
                    mainAxisAlignment: isProcessing ? MainAxisAlignment.center : MainAxisAlignment.spaceEvenly,
                    children: [
                      // Yes Button
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: isProcessing 
                            ? BorderSide.none 
                            : BorderSide(color: Colors.white, width: 2),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        ),
                        onPressed: isProcessing 
                            ? null 
                            : () async {
                                setState(() => isProcessing = true);
                                
                                try {
                                  if (isFavorite) {
                                    await favoriteProvider.removeFavorite(
                                      userProvider.currentUser!.id.toString(),
                                      product.id.toString()
                                    );
                                  } else {
                                    await favoriteProvider.addFavorite(
                                      userProvider.currentUser!.id.toString(),
                                      product.id.toString() 
                                    );
                                  }
                                  
                                  await favoriteProvider.fetchFavorites(
                                    userProvider.currentUser!.id.toString()
                                  );
                                  
                                  Navigator.pop(context);
                                  showSuccessDialog(context, isFavorite);
                                } catch (e) {
                                  setState(() => isProcessing = false);
                                }
                              },
                        child: isProcessing
                          ? SizedBox(
                              width: 40,
                              height: 40,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              AppLocalizations.of(context)!.app_yes,
                              style: GoogleFonts.pressStart2p(
                                fontSize: 12,
                                letterSpacing: 1,
                              ),
                            ),
                      ),

                      // No Button
                      if (!isProcessing)
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
                          "NO",
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
          );
        },
      ),
    );
  }

  static Future<dynamic> showSuccessDialog(BuildContext context, bool isFavorite) {
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
              FittedBox(
                child: Text(
                  isFavorite ? AppLocalizations.of(context)!.favorite_removed_dialog_title : AppLocalizations.of(context)!.favorite_added_dialog_title,
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
              ),
              
              SizedBox(height: 25),
              
              // General Information
              _buildInfoSection(
                title: isFavorite ? AppLocalizations.of(context)!.favorite_removed_dialog_label : AppLocalizations.of(context)!.favorite_added_dialog_label,
                content: isFavorite 
                  ? ""
                  : AppLocalizations.of(context)!.favorite_added_dialog_text,
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
                    AppLocalizations.of(context)!.favorite_added_dialog_button,
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
      )
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
            Flexible(
              child: Text(
                title,
                style: GoogleFonts.pressStart2p(
                  fontSize: 12,
                  color: color,
                ),
                softWrap: true,
              ),
            ),
          ],
        ),
      ],

      // Title without icon
      if (icon == null)
        FittedBox(
          child: Text(
            title,
            style: GoogleFonts.pressStart2p(
              fontSize: 12,
              color: color,
            ),
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