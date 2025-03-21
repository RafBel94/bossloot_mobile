class FieldValidator {
  final String? value;

  const FieldValidator({required this.value});

  String? validateEmail() {
    if (value == null || value!.trim().isEmpty) {
      return 'Please enter your email';
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value!)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validateName() {
    if (value == null || value!.trim().isEmpty) {
      return 'Please enter your name';
    } else if (value!.length > 40) {
      return 'Name must not be more than 40 characters long';
    } else if (!RegExp(r'^[a-zA-Z]+( [a-zA-Z]+)*$').hasMatch(value!)) {
      return 'Name can only contain letters';
    }
    return null;
  }

  String? validatePassword() {
    if (value == null || value!.trim().isEmpty) {
      return 'Please enter a password';
    } else if (value!.length > 30) {
      return 'Password must not be more than 30 characters long';
    } else if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~.]).{1,}$').hasMatch(value!)) {
      return 'Password must contain one uppercase, one lowercase, one number, and one special character including the point';
    }
    return null;
  }

  String? validateRepeatPassword(String password) {
    if (value == null || value!.trim().isEmpty) {
      return 'Please repeat your password';
    } else if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }
}
