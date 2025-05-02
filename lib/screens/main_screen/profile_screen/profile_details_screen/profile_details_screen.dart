import 'dart:io';

import 'package:bossloot_mobile/domain/models/user.dart';
import 'package:bossloot_mobile/providers/user_provider.dart';
import 'package:flutter/material.dart';
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
      // Aquí podrías subir la imagen a tu backend o guardarla en el estado de la app
    }
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      // Aquí guardarías los cambios, por ejemplo:
      // userProvider.updateUserProfile(
      //   name: _nameController.text,
      //   mobilePhone: _mobilePhoneController.text,
      //   address1: _address1Controller.text,
      //   address2: _address2Controller.text,
      //   profilePicture: _selectedImage,
      // );
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Perfil actualizado correctamente')),
      );
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
        // MAIN CONTAINER
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
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: const Color.fromARGB(88, 255, 255, 255),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Profile Image Section
                      GestureDetector(
                        onTap: _pickImage,
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.grey[200],
                              backgroundImage: _selectedImage != null 
                                  ? FileImage(_selectedImage!) as ImageProvider
                                  : (user?.profilePicture != null 
                                      ? NetworkImage(user!.profilePicture) 
                                      : const AssetImage('assets/images/placeholder_user.png') as ImageProvider),
                            ),
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
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // Divider
                      Container(
                        height: 1,
                        color: Colors.grey[300],
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // Name Field
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Nombre',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          prefixIcon: const Icon(Icons.person),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa tu nombre';
                          }
                          return null;
                        },
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Mobile Phone Field
                      TextFormField(
                        controller: _mobilePhoneController,
                        decoration: InputDecoration(
                          labelText: 'Teléfono Móvil',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          prefixIcon: const Icon(Icons.phone_android),
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa tu número de teléfono';
                          }
                          // Validación básica de número de teléfono
                          if (!RegExp(r'^\d{9,}$').hasMatch(value)) {
                            return 'Ingresa un número de teléfono válido';
                          }
                          return null;
                        },
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Address 1 Field
                      TextFormField(
                        controller: _address1Controller,
                        decoration: InputDecoration(
                          labelText: 'Dirección Línea 1',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          prefixIcon: const Icon(Icons.home),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa tu dirección';
                          }
                          return null;
                        },
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Address 2 Field
                      TextFormField(
                        controller: _address2Controller,
                        decoration: InputDecoration(
                          labelText: 'Dirección Línea 2 (Opcional)',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          prefixIcon: const Icon(Icons.home_work),
                        ),
                        // No validator needed as this field is optional
                      ),
                      
                      const SizedBox(height: 30),
                      
                      // Save Button
                      ElevatedButton(
                        onPressed: _saveProfile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Guardar Cambios',
                          style: TextStyle(fontSize: 16),
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