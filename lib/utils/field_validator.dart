import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FieldValidator {
  final BuildContext context;
  final String? value;

  const FieldValidator({required this.context, required this.value});

  String? validateEmail() {
    if (value == null || value!.trim().isEmpty) {
      return AppLocalizations.of(context)!.app_empty_email;
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value!)) {
      return AppLocalizations.of(context)!.app_invalid_email;
    }
    return null;
  }

  String? validateName() {
    if (value == null || value!.trim().isEmpty) {
      return AppLocalizations.of(context)!.app_empty_name;
    } else if (value!.length > 40) {
      return AppLocalizations.of(context)!.app_name_too_long;
    } else if (!RegExp(r'^[a-zA-Z]+( [a-zA-Z]+)*$').hasMatch(value!)) {
      return AppLocalizations.of(context)!.app_name_invalid;
    }
    return null;
  }

  String? validatePassword() {
    if (value == null || value!.trim().isEmpty) {
      return AppLocalizations.of(context)!.app_empty_password;
    } else if (value!.length > 30) {
      return AppLocalizations.of(context)!.app_password_too_long;
    } else if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~.]).{1,}$').hasMatch(value!)) {
      return AppLocalizations.of(context)!.app_invalid_password;
    }
    return null;
  }

  String? validateRepeatPassword(String password) {
    if (value == null || value!.trim().isEmpty) {
      return AppLocalizations.of(context)!.app_repeat_password_empty;
    } else if (value != password.trim()) {
      return AppLocalizations.of(context)!.app_passwords_do_not_match;
    }
    return null;
  }
}
