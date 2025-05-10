// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:bossloot_mobile/providers/contact_provider.dart';
import 'package:bossloot_mobile/providers/user_provider.dart';
import 'package:bossloot_mobile/screens/loading_screen/loading_screen_plain.dart';
import 'package:bossloot_mobile/utils/dialog_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  late ContactProvider contactProvider;
  late UserProvider userProvider;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  File? _selectedImage;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    userProvider = context.read<UserProvider>();
    contactProvider = context.read<ContactProvider>();
    _nameController.text = userProvider.currentUser?.name ?? '';
    _emailController.text = userProvider.currentUser?.email ?? '';
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

  void _sendContactForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Send the contact form data
      bool success = await contactProvider.sendContactForm(
        _nameController.text.replaceAll(RegExp(r'\s+'), ' ').trim(),
        _emailController.text.trim(),
        _subjectController.text.replaceAll(RegExp(r'\s+'), ' ').trim(),
        _messageController.text.trim(),
        _selectedImage,
      );
      
      setState(() {
        _isLoading = false;
      });
      
      if (!success) {
        DialogUtil.showContactErrorDialog(context);
      } else {
        DialogUtil.showContactSuccessDialog(context);
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // MAIN CONTAINER (Background Image)
        child: _isLoading 
        ? LoadingScreenPlain(redirect: false,)
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
                          SizedBox(height: 32),
                          
                          // Header
                          Text(
                            AppLocalizations.of(context)!.contact_screen_header,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple,
                            ),
                          ),
                          
                          const SizedBox(height: 10),
              
                          // Divider
                          Container(
                            height: 1,
                            color: Colors.grey[300],
                          ),
                          
                          const SizedBox(height: 20),
                          
                          // Name Field
                          TextFormField(
                            onTapUpOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                            controller: _nameController,
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)!.contact_screen_name_label,
                              hintText: AppLocalizations.of(context)!.contact_screen_name_hint,
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
                          
                          // Email Field
                          TextFormField(
                            onTapUpOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)!.contact_screen_email_label,
                              hintText: AppLocalizations.of(context)!.contact_screen_email_hint,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              prefixIcon: const Icon(Icons.email),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppLocalizations.of(context)!.app_empty_email;
                              }
                              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                                return AppLocalizations.of(context)!.app_invalid_email;
                              }
                              return null;
                            },
                          ),
                          
                          const SizedBox(height: 20),
                          
                          // Subject Field
                          TextFormField(
                            onTapUpOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                            controller: _subjectController,
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)!.contact_screen_subject_label,
                              hintText: AppLocalizations.of(context)!.contact_screen_subject_hint,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              prefixIcon: const Icon(Icons.subject),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppLocalizations.of(context)!.contact_screen_empty_subject;
                              }
                              return null;
                            },
                          ),
                          
                          const SizedBox(height: 20),
                          
                          // Message Field
                          TextFormField(
                            onTapUpOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                            controller: _messageController,
                            maxLength: 255,
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)!.contact_screen_message_label,
                              hintText: AppLocalizations.of(context)!.contact_screen_message_hint,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              alignLabelWithHint: true,
                            ),
                            maxLines: 5,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppLocalizations.of(context)!.contact_screen_empty_message;
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 10),

                          // Attack image
                          Text(
                            AppLocalizations.of(context)!.contact_screen_upload_image,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 10),

                          // Image Selection
                          GestureDetector(
                            onTap: _pickImage,
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: const Color.fromRGBO(156, 39, 176, 0.5),
                                  width: 2,
                                ),
                              ),
                              child: _selectedImage != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(6),
                                    child: Image.file(
                                      _selectedImage!,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Icon(
                                  Icons.add_photo_alternate,
                                  size: 50,
                                  color: Colors.purple,
                                ),
                            ),
                          ),
                          
                          const SizedBox(height: 25),
                          
                          // Send Button
                          ElevatedButton(
                            onPressed: _sendContactForm,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purple,
                              foregroundColor: Colors.white,
                              minimumSize: const Size(200, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.contact_screen_send_button,
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
                top: 4,
                right: 0,
                left: 0,
                child: GestureDetector(
                  onTap: () {
                    DialogUtil.showContactFormGuideDialog(context);
                  },
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                        color: const Color.fromARGB(84, 196, 196, 196),
                        border: Border.all(color: const Color.fromARGB(185, 133, 133, 133), width: 2),
                      ),
                      child: Icon(
                        Icons.question_mark,
                        color: const Color.fromARGB(255, 144, 10, 178),
                        size: 18,
                      ),
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