// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:bossloot_mobile/domain/models/user.dart';
import 'package:bossloot_mobile/providers/user_provider.dart';
import 'package:bossloot_mobile/screens/loading_screen/loading_screen_plain.dart';
import 'package:bossloot_mobile/screens/main_screen/main_screen.dart';
import 'package:bossloot_mobile/utils/dialog_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  bool _isLoading = false;

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
      setState(() {
        _isLoading = true;
      });

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
          builder: (context) => const MainScreen(withPageIndex: 4,),
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
        child: _isLoading 
        ? LoadingScreenPlain(redirect: true,)
        : Container(
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
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                color: const Color.fromARGB(204, 136, 25, 156),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color.fromARGB(150, 223, 64, 251),
                  width: 1,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(156, 39, 176, 0.5),
                    blurRadius: 6,
                    spreadRadius: 3,
                  ),
                ],
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
                                      child: _selectedImage != null
                                          ? Image.file(
                                              _selectedImage!,
                                              fit: BoxFit.cover,
                                              width: 150,
                                              height: 150,
                                            )
                                          : Image.network(
                                              '${user?.profilePicture}',
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
                                    padding: const EdgeInsets.all(8),
                                    decoration: const BoxDecoration(
                                      color: Colors.purple,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.add_photo_alternate_outlined,
                                      color: Colors.white,
                                      size: 25,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          const SizedBox(height: 20),
              
                          // User Level
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
                                "${AppLocalizations.of(context)!.profile_details_level_label}: ${user!.level}",
                                maxLines: 1,
                                style: GoogleFonts.pressStart2p(
                                  fontSize: 17,
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
                                "${AppLocalizations.of(context)!.profile_details_experience_label}: ${user!.points}",
                                maxLines: 1,
                                style: GoogleFonts.pressStart2p(
                                  fontSize: 15,
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
                              labelText: AppLocalizations.of(context)!.profile_details_name_field_label,
                              hintText: AppLocalizations.of(context)!.profile_details_name_field_hint,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              prefixIcon: const Icon(Icons.person),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppLocalizations.of(context)!.app_empty_name;
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
                              labelText: AppLocalizations.of(context)!.profile_details_mobile_field_label,
                              hintText: AppLocalizations.of(context)!.profile_details_phone_field_hint,
                              border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              ),
                              prefixIcon: const Icon(Icons.phone_android),
                            ),
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value != null && value.isNotEmpty) {
                                // Validate phone number only if it has a value
                                if (!RegExp(r'^\d{9,}$').hasMatch(value)) {
                                  return AppLocalizations.of(context)!.app_invalid_phone_number;
                                }
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
                              labelText: AppLocalizations.of(context)!.profile_details_address1_field_label,
                              hintText: AppLocalizations.of(context)!.profile_details_address1_field_hint,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              prefixIcon: const Icon(Icons.home),
                            ),
                            validator: (value) {
                              return null;
                            },
                          ),
                          
                          const SizedBox(height: 20),
                          
                          // Address 2 Field
                          TextFormField(
                            onTapUpOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                            controller: _address2Controller,
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)!.profile_details_address2_field_label,
                              hintText: AppLocalizations.of(context)!.profile_details_address2_field_hint,
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
                            child: Text(
                              AppLocalizations.of(context)!.profile_details_save_button,
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