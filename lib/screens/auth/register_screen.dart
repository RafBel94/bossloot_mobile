import 'dart:ui';

import 'package:bossloot_mobile/actions/register_action.dart';
import 'package:bossloot_mobile/screens/auth/login_screen.dart';
import 'package:bossloot_mobile/utils/field_validator.dart';
import 'package:bossloot_mobile/utils/text_util.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  double _opacity = 0.0;
  bool _passwordHidden = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
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

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: sizes.height,
            width: sizes.width,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/retrowave-bg-1.jpg'),
                fit: BoxFit.fill,
              ),
            ),
            child: AnimatedOpacity(
              opacity: _opacity,
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeIn,
                  
              // Main Container
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 100),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromARGB(41, 207, 207, 207),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                  
                      // Form
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            // Back Button
                            IconButton(
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

                            const Spacer(),
                  
                            // Register Title
                            Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              child: const Center(
                                child: Text(
                                  "Register",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                  
                            const Spacer(),
                  
                            // Name Field
                            TextUtil(text: "Name", isBold: true, size: 18, color: Colors.white),
                            Container(
                              height: 35,
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: const BoxDecoration(
                                border: Border(bottom: BorderSide(color: Colors.white)),
                              ),
                              child: TextFormField(
                                onTapOutside: (event) => FocusScope.of(context).unfocus(),
                                controller: _nameController,
                                style: const TextStyle(color: Colors.white),
                                decoration: const InputDecoration(
                                  suffixIcon: Icon(Icons.supervised_user_circle_outlined, color: Colors.white),
                                  fillColor: Colors.white,
                                  border: InputBorder.none,
                                ),
                                validator: (value) => FieldValidator(value: value).validateName(),
                              ),
                            ),
                  
                            const Spacer(),
                  
                            // Email Field
                            TextUtil(text: "Email", isBold: true, size: 18, color: Colors.white),
                            Container(
                              height: 35,
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: const BoxDecoration(
                                border: Border(bottom: BorderSide(color: Colors.white)),
                              ),
                              child: TextFormField(
                                onTapOutside: (event) => FocusScope.of(context).unfocus(),
                                controller: _emailController,
                                style: const TextStyle(color: Colors.white),
                                decoration: const InputDecoration(
                                  suffixIcon: Icon(Icons.mail, color: Colors.white),
                                  fillColor: Colors.white,
                                  border: InputBorder.none,
                                ),
                                validator: (value) => FieldValidator(value: value).validateEmail(),
                              ),
                            ),
                  
                            const Spacer(),
                  
                            // Password Field
                            TextUtil(text: "Password", isBold: true, size: 18, color: Colors.white),
                            Container(
                              height: 35,
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: const BoxDecoration(
                                border: Border(bottom: BorderSide(color: Colors.white)),
                              ),
                              child: TextFormField(
                                onTapOutside: (event) => FocusScope.of(context).unfocus(),
                                controller: _passwordController,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _passwordHidden = !_passwordHidden;
                                      });
                                    },
                                    icon: _passwordHidden ? const Icon(Icons.visibility_off, color: Colors.white) : const Icon(Icons.visibility, color: Colors.white),
                                  ),
                                  fillColor: Colors.white,
                                  border: InputBorder.none,
                                ),
                                obscureText: _passwordHidden,
                                validator: (value) => FieldValidator(value: value).validatePassword(),
                              ),
                            ),
                  
                            const Spacer(),
                  
                            // Repeat Password Field
                            TextUtil(text: "Repeat password", isBold: true, size: 18, color: Colors.white),
                            Container(
                              height: 35,
                              margin: const EdgeInsets.only(bottom: 20),
                              decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white))),
                              child: TextFormField(
                                onTapOutside: (event) => FocusScope.of(context).unfocus(),
                                controller: _repeatPasswordController,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _passwordHidden = !_passwordHidden;
                                      });
                                    },
                                    icon: _passwordHidden ? const Icon(Icons.visibility_off, color: Colors.white) : const Icon(Icons.visibility, color: Colors.white),
                                  ),
                                ),
                                obscureText: _passwordHidden,
                                validator: (value) => FieldValidator(value: value).validateRepeatPassword(_passwordController.text),
                              ),
                            ),
                  
                            const Spacer(),
                  
                            // Register Button
                            Center(
                              child: RegisterButton(
                                emailController: _emailController,
                                passwordController: _passwordController,
                                repeatPasswordController: _repeatPasswordController,
                                nameController: _nameController,
                                formKey: _formKey,
                              ),
                            ),
                  
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ),
    );
  }
}

class RegisterButton extends StatelessWidget {
  final GlobalKey<FormState> _formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController repeatPasswordController;
  final TextEditingController nameController;

  const RegisterButton({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.emailController,
    required this.passwordController,
    required this.repeatPasswordController,
    required this.nameController,
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
              registerAction(context, nameController.text, emailController.text, passwordController.text, repeatPasswordController.text);
            }
          },
          child: Text(
            "Register",
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