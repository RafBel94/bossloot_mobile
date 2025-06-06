import 'dart:ui';

import 'package:bossloot_mobile/actions/resend_verification_action.dart';
import 'package:bossloot_mobile/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background-image-workshop.png'),
            fit: BoxFit.fill,
          ),
        ),

        // Animated opacity for fade-in effect
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: Duration(milliseconds: 800),
          curve: Curves.easeIn,

          // Main content container
          child: Container(
            height: MediaQuery.of(context).size.height * 0.7,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 30.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(15),
              color: const Color.fromARGB(41, 207, 207, 207),
            ),

            // Blurred background filter
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),

                // Padding for inner content
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 40),
                  
                      // Info title 1
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Center(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                                AppLocalizations.of(context)!.verify_email_screen_title,
                                textAlign: TextAlign.center,
                                maxLines: 3,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),
                  
                      // Info title 2
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: Center(
                          child: Text(
                              AppLocalizations.of(context)!.verify_email_screen_text,
                              textAlign: TextAlign.center,
                              maxLines: 6,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  
                      const SizedBox(height: 20),
                      // Resend label
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: Center(
                          child: Text(
                              AppLocalizations.of(context)!.verify_email_screen_resend,
                              textAlign: TextAlign.center,
                              maxLines: 3,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  
                      // Resend button
                      Container(
                        margin: const EdgeInsets.only(bottom: 50),
                        child: Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 7),
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                            ),
                            onPressed: () {
                              resendVerificationAction(context);
                            },
                            child: Text(
                              AppLocalizations.of(context)!.verify_email_screen_resend_button,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                  
                      // Back Button
                      Center(
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.white),
                          style: IconButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 141, 70, 154),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            side: BorderSide(color: Colors.white),
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                          },
                        ),
                      )
                  
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}