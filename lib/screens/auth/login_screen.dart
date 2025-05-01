import 'dart:ui';
import 'package:bossloot_mobile/actions/login_action.dart';
import 'package:bossloot_mobile/screens/auth/register_screen.dart';
import 'package:bossloot_mobile/utils/text_util.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  double _opacity = 0.0;
  bool _passwordVisible = false;
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

    final sizes = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
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
                                      "Login",
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
                                TextUtil(text: "Email", isBold: true, size: 20, color: Colors.white),
                
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
              ],
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