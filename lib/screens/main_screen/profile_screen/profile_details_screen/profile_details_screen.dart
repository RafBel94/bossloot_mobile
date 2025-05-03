// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:bossloot_mobile/domain/models/user.dart';
import 'package:bossloot_mobile/providers/user_provider.dart';
import 'package:bossloot_mobile/screens/auth/login_screen.dart';
import 'package:bossloot_mobile/utils/dialog_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileDetailsScreen extends StatefulWidget {
  const ProfileDetailsScreen({super.key});

  @override
  State<ProfileDetailsScreen> createState() => _ProfileDetailsScreenState();
}

class _ProfileDetailsScreenState extends State<ProfileDetailsScreen> {
  late User? user;
  late UserProvider userProvider;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobilePhoneController = TextEditingController();
  final TextEditingController _address1Controller = TextEditingController();
  final TextEditingController _address2Controller = TextEditingController();
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    userProvider = context.read<UserProvider>();
    user = userProvider.currentUser;
    _initControllers();
  }

  void _initControllers() {
    if (user != null) {
      _nameController.text = user!.name;
      _mobilePhoneController.text = user!.mobilePhone ?? '';
      _address1Controller.text = user!.address_1 ?? '';
      _address2Controller.text = user!.address_2 ?? '';
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  void _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      // Save the profile data
      await userProvider.updateUser(
        user!.id,
        _nameController.text.replaceAll(RegExp(r'\s+'), ' ').trim(),
        _mobilePhoneController.text.replaceAll(RegExp(r'\s+'), ' ').trim(),
        _address1Controller.text.replaceAll(RegExp(r'\s+'), ' ').trim(),
        _address2Controller.text.replaceAll(RegExp(r'\s+'), ' ').trim(),
        _selectedImage
      );
      
      if (userProvider.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(userProvider.errorMessage!)),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully! Please log in again')),
        );

        userProvider.logoutUser();
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ));
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _mobilePhoneController.dispose();
    _address1Controller.dispose();
    _address2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(

        // MAIN CONTAINER (Background Image)
        child: Container(
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background-image-workshop-2.png'),
              fit: BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.all(16),

          // MAIN CARD
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(88, 255, 255, 255),
                  borderRadius: BorderRadius.circular(5),
                ),
              
                // INNER CARD
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 10),
              
                          // Profile Image
                          GestureDetector(
                            onTap: _pickImage,
                            child: Stack(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: const Color.fromARGB(150, 50, 20, 183),
                                      width: 5,
                                    ),
                                  ),
                                  child: CircleAvatar(
                                    radius: 75,
                                    backgroundColor: const Color.fromARGB(255, 226, 226, 226),
                                    child: ClipOval(
                                      child: Image.network('${user?.profilePicture}',
                                        fit: BoxFit.cover,
                                        width: 150,
                                        height: 150,
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
              
                                // Select Image Icon
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: const BoxDecoration(
                                      color: Colors.purple,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          const SizedBox(height: 20),
              
                          // User Level Image
                          Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            child: ShaderMask(
                              shaderCallback: (Rect bounds) {
                                return LinearGradient(
                                  colors: [
                                    Color.fromARGB(255, 180, 47, 236),
                                    Color.fromARGB(255, 136, 76, 239),
                                    Color.fromARGB(255, 233, 30, 179),
                                  ],
                                  stops: [0.0, 0.3, 0.7],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  tileMode: TileMode.clamp,
                                ).createShader(bounds);
                              },
                              child: Text(
                                "Level: ${user!.level}",
                                maxLines: 1,
                                style: GoogleFonts.pressStart2p(
                                  fontSize: 18,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      color: const Color.fromRGBO(0, 0, 0, 0.5),
                                      offset: Offset(2, 2),
                                      blurRadius: 3,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
              
                          const SizedBox(height: 5),
                          
                          // Experience points
                          Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            child: ShaderMask(
                              shaderCallback: (Rect bounds) {
                                return LinearGradient(
                                  colors: [
                                    Color.fromARGB(255, 180, 47, 236),
                                    Color.fromARGB(255, 136, 76, 239),
                                    Color.fromARGB(255, 233, 30, 179),
                                  ],
                                  stops: [0.0, 0.3, 0.7],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  tileMode: TileMode.clamp,
                                ).createShader(bounds);
                              },
                              child: Text(
                                "Experience: ${user!.points}",
                                maxLines: 1,
                                style: GoogleFonts.pressStart2p(
                                  fontSize: 16,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      color: const Color.fromRGBO(0, 0, 0, 0.5),
                                      offset: Offset(2, 2),
                                      blurRadius: 3,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
              
                          const SizedBox(height: 20),
              
                          // Divider
                          Container(
                            height: 1,
                            color: Colors.grey[300],
                          ),
                          
                          const SizedBox(height: 30),
                          
                          // Name Field
                          TextFormField(
                            onTapUpOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                            controller: _nameController,
                            decoration: InputDecoration(
                              labelText: 'Name',
                              hintText: 'Your name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              prefixIcon: const Icon(Icons.person),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                          ),
                          
                          const SizedBox(height: 20),
                          
                          // Mobile Phone Field
                          TextFormField(
                            onTapUpOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                            controller: _mobilePhoneController,
                            decoration: InputDecoration(
                              labelText: 'Mobile Phone',
                              hintText: 'Your mobile phone number',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              prefixIcon: const Icon(Icons.phone_android),
                            ),
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your mobile phone number';
                              }
                              // Basic validation for phone number
                              if (!RegExp(r'^\d{9,}$').hasMatch(value)) {
                                return 'Please enter a valid phone number';
                              }
                              return null;
                            },
                          ),
                          
                          const SizedBox(height: 20),
                          
                          // Address 1 Field
                          TextFormField(
                            onTapUpOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                            controller: _address1Controller,
                            decoration: InputDecoration(
                              labelText: 'Address 1',
                              hintText: 'Your address',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              prefixIcon: const Icon(Icons.home),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your address';
                              }
                              return null;
                            },
                          ),
                          
                          const SizedBox(height: 20),
                          
                          // Address 2 Field
                          TextFormField(
                            onTapUpOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                            controller: _address2Controller,
                            decoration: InputDecoration(
                              labelText: 'Address 2',
                              hintText: 'Your secondary address',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              prefixIcon: const Icon(Icons.home_work),
                            ),
                          ),
                          
                          const SizedBox(height: 25),
                          
                          // Save Button
                          ElevatedButton(
                            onPressed: _saveProfile,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purple,
                              foregroundColor: Colors.white,
                              minimumSize: const Size(100, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Save Changes',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Help Icon
              Positioned(
                top: 10,
                right: 10,
                child: GestureDetector(
                  onTap: () {
                    DialogUtil.showUserProfileGuideDialog(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color.fromARGB(84, 196, 196, 196),
                      border: Border.all(color: const Color.fromARGB(185, 133, 133, 133), width: 2),
                    ),
                    child: Icon(
                      Icons.question_mark,
                      color: const Color.fromARGB(255, 93, 93, 93),
                      size: 20,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}