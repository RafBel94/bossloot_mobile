import 'dart:ui';
import 'package:bossloot_mobile/actions/login_action.dart';
import 'package:bossloot_mobile/screens/register_screen.dart';
import 'package:bossloot_mobile/utils/text_util.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  double _opacity = 0.0;
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
                              "Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        const Spacer(),
                        // Email label
                        TextUtil(text: "Email", isBold: true, size: 20, color: Colors.white),

                        // Email input field
                        Container(
                          height: 35,
                          decoration: const BoxDecoration(
                            border: Border(bottom: BorderSide(color: Colors.white)),
                          ),
                          child: TextFormField(
                            onTapOutside: (event) {
                              FocusScope.of(context).unfocus();
                            },
                            controller: _emailController,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              suffixIcon: Icon(Icons.mail, color: Colors.white),
                              fillColor: Colors.white,
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                        ),

                        const Spacer(),
                        const Spacer(),
                        // Password label
                        TextUtil(text: "Password", isBold: true, size: 20, color: Colors.white),

                        // Password input field
                        Container(
                          height: 35,
                          decoration: const BoxDecoration(
                            border: Border(bottom: BorderSide(color: Colors.white)),
                          ),
                          child: TextFormField(
                            onTapOutside: (event) {
                              FocusScope.of(context).unfocus();
                            },
                            controller: _passwordController,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              suffixIcon: Icon(Icons.lock, color: Colors.white),
                              fillColor: Colors.white,
                              border: InputBorder.none,
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),
                        ),

                        const Spacer(),
                        // Login button
                        LoginButton(formKey: _formKey, emailController: _emailController, passwordController: _passwordController,),

                        const Spacer(),
                        // Register section
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextUtil(text: "Don't have an account?", isBold: true, color: Colors.white),

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