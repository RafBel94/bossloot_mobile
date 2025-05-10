import 'package:bossloot_mobile/domain/models/user.dart';
import 'package:bossloot_mobile/providers/coin_exchange_provider.dart';
import 'package:bossloot_mobile/providers/language_provider.dart';
import 'package:bossloot_mobile/screens/main_screen/profile_screen/settings_screen/settings_custom_appbar.dart';
import 'package:bossloot_mobile/screens/main_screen/profile_screen/settings_screen/settings_screen_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  final User? user;

  const SettingsScreen({super.key, required this.user});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isLoading = true;
  
  // Options for dropdowns
  final Map<String, String> _languageMap = {
    'es': 'ESPAÑOL',
    'en': 'ENGLISH',
  };

  final Map<String, String> _currencyMap = {
    'EUR': 'EUR - EURO',
    'USD': 'USD - UNITED STATES DOLLAR',
    'CAD': 'CAD - CANADIAN DOLLAR',
    'AUD': 'AUD - AUSTRALIAN DOLLAR',
    'NZD': 'NZD - NEW ZEALAND DOLLAR',
    'SGD': 'SGD - SINGAPORE DOLLAR',
    'HKD': 'HKD - HONG KONG DOLLAR',
    'TWD': 'TWD - NEW TAIWAN DOLLAR',
  };

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

    LanguageProvider languageProvider = context.watch<LanguageProvider>();
    CoinExchangeProvider coinExchangeProvider = context.watch<CoinExchangeProvider>();
    String selectedLanguage = languageProvider.locale.languageCode;
    String selectedCurrency = coinExchangeProvider.selectedCurrency;

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
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 25),
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
                      SettingsScreenDropdown(
                        label: AppLocalizations.of(context)!.settings_screen_language_label,
                        selectedValue: selectedLanguage,
                        options: _languageMap,
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              selectedLanguage = newValue;
                              languageProvider.setLocale(Locale(newValue));
                            });
                          }
                        },
                      ),

                      const SizedBox(height: 15),
                      
                      // CURRENCY DROPDOWN SECTION
                      SettingsScreenDropdown(
                        label: AppLocalizations.of(context)!.settings_screen_currency_label,
                        selectedValue: selectedCurrency,
                        options: _currencyMap,
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              selectedCurrency = newValue;
                              coinExchangeProvider.setSelectedCurrency(newValue);
                            });
                          }
                        },
                      ),
                      
                      // SAVE BUTTON
                      // SettingsSaveButton(selectedLanguage: selectedLanguage, selectedCurrency: selectedCurrency),
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
