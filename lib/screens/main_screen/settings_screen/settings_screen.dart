import 'package:bossloot_mobile/domain/models/user.dart';
import 'package:bossloot_mobile/screens/main_screen/settings_screen/settings_custom_appbar.dart';
import 'package:bossloot_mobile/screens/main_screen/settings_screen/settings_save_button.dart';
import 'package:bossloot_mobile/screens/main_screen/settings_screen/settings_screen_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsScreen extends StatefulWidget {
  final User? user;

  const SettingsScreen({super.key, required this.user});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isLoading = true;
  
  // Selected values for dropdowns
  String _selectedLanguage = 'English';
  String _selectedCurrency = 'USD';
  
  // Options for dropdowns
  final List<String> _languages = ['English', 'Español'];
  final List<String> _currencies = ['USD', 'EUR'];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Scaffold(
          extendBodyBehindAppBar: true,

          // APPBAR
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: SettingsCustomAppbar()
          ),
          
          // BODY
          body: Container(
            padding: const EdgeInsets.fromLTRB(16, 70, 16, 16),
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background-image-workshop-2.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
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
              child: Container(
                margin: const EdgeInsets.all(4),
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 30, 5, 40),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: _isLoading 
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [

                      // LANGUAGE DROPDOWN SECTION
                      SettingsScreenDropdown(label: AppLocalizations.of(context)!.settings_screen_language_label, selectedValue: _selectedLanguage, options: _languages, onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            _selectedLanguage = newValue;
                          });
                        }
                      }),
                      
                      // CURRENCY DROPDOWN SECTION
                      SettingsScreenDropdown(label: AppLocalizations.of(context)!.settings_screen_currency_label, selectedValue: _selectedCurrency, options: _currencies, onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            _selectedCurrency = newValue;
                          });
                        }
                      }),
                      
                      // SAVE BUTTON
                      SettingsSaveButton(selectedLanguage: _selectedLanguage, selectedCurrency: _selectedCurrency),
                    ],
                  )
              ),
            ),
          )
        ),
      )
    );
  }
}
