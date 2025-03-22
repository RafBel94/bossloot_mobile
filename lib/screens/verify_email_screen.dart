import 'dart:ui';
import 'package:bossloot_mobile/actions/login_action.dart';
import 'package:bossloot_mobile/actions/resend_verification_action.dart';
import 'package:bossloot_mobile/providers/user_provider.dart';
import 'package:bossloot_mobile/screens/login_screen.dart';
import 'package:bossloot_mobile/screens/register_screen.dart';
import 'package:bossloot_mobile/utils/text_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
            image: AssetImage('assets/images/background-2.jpeg'),
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
            height: 500,
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
                    children: [
                      SizedBox(height: 40),
                  
                      // Info title 1
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Center(
                          child: Text(
                              "Oops!",
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
                  
                      // Info title 2
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: Center(
                          child: Text(
                              "Looks like you still have to verify your email.",
                              textAlign: TextAlign.center,
                              maxLines: 3,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  
                      const Spacer(),
                      // Resend label
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: Center(
                          child: Text(
                              "Do you want to receive another verification email?",
                              textAlign: TextAlign.center,
                              maxLines: 3,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
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
                              "Resend email",
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

class RegisterButton extends StatelessWidget {
  const RegisterButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const RegisterScreen()));
      },
      child: TextUtil(text: "Register", isBold: true)
    );
  }
}

class LoginButton extends StatelessWidget {
  final GlobalKey<FormState> _formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginButton({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.emailController,
    required this.passwordController,
  }) : _formKey = formKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 25, bottom: 10),
      child: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 7),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              loginAction(context, emailController.text, passwordController.text);
            }
          },
          child: Text(
            "Login",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}