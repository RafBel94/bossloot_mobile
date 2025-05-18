import 'dart:ui';
import 'package:bossloot_mobile/actions/login_action.dart';
import 'package:bossloot_mobile/screens/auth/register_screen.dart';
import 'package:bossloot_mobile/utils/text_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  double _opacity = 0.0;
  bool _passwordVisible = false;
  // Add loading state variable
  bool _isLoading = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  // Function to show loading overlay
  void _showLoading() {
    setState(() {
      _isLoading = true;
    });
  }

  // Function to hide loading overlay
  void _hideLoading() {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final sizes = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Main content
          SingleChildScrollView(
            child: Container(
              height: sizes.height,
              width: sizes.width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background-image-workshop.png'),
                  fit: BoxFit.cover,
                ),
              ),
            
              // Animated opacity for fade-in effect
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: sizes.height * 0.08),
                child: Column(
                  children: [
                    Image(
                      image: AssetImage('assets/images/bossloot-logo-full.png'),
                      height: sizes.height * 0.17,
                    ),
                        
                    SizedBox(height: sizes.height * 0.02),
                        
                    AnimatedOpacity(
                      opacity: _opacity,
                      duration: Duration(milliseconds: 800),
                      curve: Curves.easeIn,
                    
                      // Main content container
                      child: Container(
                        height: sizes.height * 0.62,
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 30.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(15),
                          color: const Color.fromARGB(71, 207, 207, 207),
                        ),
                    
                        // Blurred background filter
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
                    
                            // Padding for inner content
                            child: Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Spacer(),
                    
                                    // Login title
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 20),
                                      child: Center(
                                        child: Text(
                                          'Login',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 33,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                    
                                    const Spacer(),
                                    // Email label
                                    TextUtil(text: AppLocalizations.of(context)!.login_screen_email_field, isBold: true, size: 20, color: Colors.white),
                    
                                    // Email input field
                                    Container(
                                      height: 35,
                                      decoration: const BoxDecoration(
                                        border: Border(bottom: BorderSide(color: Colors.white)),
                                      ),
                                      child: TextFormField(
                                        onTapOutside: (event) {
                                          FocusManager.instance.primaryFocus?.unfocus();
                                        },
                                        controller: _emailController,
                                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                        decoration: const InputDecoration(
                                          suffixIcon: Icon(Icons.mail, color: Colors.white),
                                          fillColor: Colors.white,
                                          border: InputBorder.none,
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return AppLocalizations.of(context)!.app_empty_email;
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                    
                                    const Spacer(),
                                    const Spacer(),
                                    // Password label
                                    TextUtil(text: AppLocalizations.of(context)!.login_screen_password_field, isBold: true, size: 20, color: Colors.white),
                    
                                    // Password input field
                                    Container(
                                      height: 35,
                                      decoration: const BoxDecoration(
                                        border: Border(bottom: BorderSide(color: Colors.white)),
                                      ),
                                      child: TextFormField(
                                        onTapOutside: (event) {
                                          FocusManager.instance.primaryFocus?.unfocus();
                                        },
                                        controller: _passwordController,
                                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                        decoration: InputDecoration(
                                          fillColor: Colors.white,
                                          border: InputBorder.none,
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              _passwordVisible ? Icons.visibility : Icons.visibility_off,
                                              color: Colors.white,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _passwordVisible = !_passwordVisible;
                                              });
                                            },
                                          ),
                                        ),
                                        obscureText: !_passwordVisible,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return AppLocalizations.of(context)!.app_empty_password;
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                    
                                    const Spacer(),
                                    // Login button
                                    LoginButton(
                                      formKey: _formKey, 
                                      emailController: _emailController, 
                                      passwordController: _passwordController,
                                      onLoginStart: _showLoading,
                                      onLoginEnd: _hideLoading,
                                    ),
                    
                                    const Spacer(),
                                    // Register section
                                    Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          TextUtil(text: AppLocalizations.of(context)!.login_screen_no_account_label, isBold: true, color: Colors.white),
                    
                                          const SizedBox(height: 7),
                    
                                          RegisterButton(),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Loading overlay
          if (_isLoading)
            Container(
              width: double.infinity,
              height: double.infinity,
              color: const Color.fromRGBO(0, 0, 0, 0.7),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3,
                    ),
                    SizedBox(height: 20),
                    Text(
                      AppLocalizations.of(context)?.app_loading ?? "Logging in...",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
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
      child: TextUtil(text: AppLocalizations.of(context)!.login_screen_register_button, isBold: true)
    );
  }
}

class LoginButton extends StatelessWidget {
  final GlobalKey<FormState> _formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Function onLoginStart;
  final Function onLoginEnd;

  const LoginButton({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.emailController,
    required this.passwordController,
    required this.onLoginStart,
    required this.onLoginEnd,
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
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              onLoginStart();
              
              try {
                await loginAction(
                  context, 
                  emailController.text.trim(), 
                  passwordController.text.trim()
                );
              } finally {
                onLoginEnd();
              }
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