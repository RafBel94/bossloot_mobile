// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:bossloot_mobile/providers/user_provider.dart';
import 'package:bossloot_mobile/providers/valoration_provider.dart';
import 'package:bossloot_mobile/screens/loading_screen/loading_screen_plain.dart';
import 'package:bossloot_mobile/utils/dialog_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddValorationScreen extends StatefulWidget {
  final int productId;
  const AddValorationScreen({super.key, required this.productId});

  @override
  State<AddValorationScreen> createState() => _AddValorationScreenState();
}

class _AddValorationScreenState extends State<AddValorationScreen> {
  late UserProvider userProvider;
  late ValorationProvider valorationProvider;
  final _formKey = GlobalKey<FormState>();
  int _valoration = 1;
  final TextEditingController _commentController = TextEditingController();
  File? _selectedImage;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    userProvider = context.read<UserProvider>();
    valorationProvider = context.read<ValorationProvider>();
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

  void _sendValorationForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Send the contact form data
      bool success = await valorationProvider.sendValorationForm(
        _valoration,
        widget.productId,
        _commentController.text.trim(),
        _selectedImage,
      );
      
      setState(() {
        _isLoading = false;
      });
      
      Navigator.pop(context);
      if (success) {
        DialogUtil.showValorationDialog(
          context,
          true,
        );
      } else {
        DialogUtil.showValorationDialog(
          context,
          false,
        );
      }
    }
  }

  @override
  void dispose() {
    _commentController.dispose();
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
          child: Container(
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
                        AppLocalizations.of(context)!.valoration_screen_title,
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
                      
                      const SizedBox(height: 30),

                      // Rating Text
                      Text(
                        AppLocalizations.of(context)!.valoration_screen_rating_label,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Star Rating Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _valoration = index + 1;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Icon(
                                index < _valoration ? Icons.star : Icons.star_border,
                                color: Colors.amber,
                                size: 40,
                              ),
                            ),
                          );
                        }),
                      ),

                      const SizedBox(height: 20),
                      
                      // Message Field
                      TextFormField(
                        onTapUpOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                        controller: _commentController,
                        maxLength: 255,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.valoration_screen_commentary_label,
                          hintText: AppLocalizations.of(context)!.valoration_screen_commentary_hint,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          alignLabelWithHint: true,
                        ),
                        maxLines: 5,
                      ),
          
                      const SizedBox(height: 20),
          
                      // Attach image
                      Text(
                        AppLocalizations.of(context)!.valoration_screen_image_label,
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
                      
                      const SizedBox(height: 40),
                      
                      // Send Button
                      ElevatedButton(
                        onPressed: () async {
                          final bool? confirm = await DialogUtil.showValorationConfirmDialog(context);
                          if (confirm == true) {
                            _sendValorationForm();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(200, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.valoration_screen_send_button,
                          style: GoogleFonts.orbitron(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
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
    );
  }
}