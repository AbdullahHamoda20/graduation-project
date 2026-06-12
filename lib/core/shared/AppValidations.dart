import 'AppRegex.dart';

abstract class AppValidations {
  static String? validateEmail(String? data) {
    if (data == null || data.isEmpty) {
      return "email can't be empty";
    }
    if (!AppRegex.isEmailValid(data)) {
      return "email is not valid";
    }
    return null;
  }

  static String? validatePassword(String? data) {
    if (data == null || data.isEmpty) {
      return "password can't be empty";
    }
    if (data.length < 8) {
      return "password must be at least 8 characters";
    }
    if (!AppRegex.isContainsNumber(data)) {
      return "password must contain at least one number";
    }
    if (!AppRegex.isContainsCapitalLetter(data)) {
      return "password must contain at least one uppercase letter";
    }
    return null;
  }

  static String? validateConfirmPassword(String? data, String? newData) {
    if (data != newData) {
      return 'Password not match';
    }
    return null;
  }

  static String? validateName(String? data) {
    if (data == null || data.isEmpty) {
      return "name can't be empty";
    }
    if (data.length < 6) {
      return "name must be at least 6 characters";
    }
    return null;
  }

  static String? validatePhone(String? data) {
    if (data == null || data.isEmpty) {
      return "phone can't be empty";
    }
    if (!AppRegex.isPhoneNumberValid(data)) {
      return "phone number is not valid";
    }
    return null;
  }

  static String? validateAge(String? data) {
    if (data == null || data.isEmpty) {
      return "age can't be empty";
    }

    final age = int.tryParse(data);
    if (age == null) {
      return "age must be a number";
    }

    if (age < 10 || age > 100) {
      return "The field Age must be between 10 and 100.";
    }

    return null;
  }


  static String? validateWeight(String? data) {
    if (data == null || data.isEmpty) {
      return "weight can't be empty";
    }

    final weight = double.tryParse(data);
    if (weight == null) {
      return "weight must be a number";
    }

    if (weight < 20 || weight > 300) {
      return "The field Weight must be between 20 and 300.";
    }

    return null;
  }

  static String? validateHeight(String? data) {
    if (data == null || data.isEmpty) {
      return "height can't be empty";
    }

    final height = double.tryParse(data);
    if (height == null) {
      return "height must be a number";
    }

    if (height < 100 || height > 250) {
      return "The field Height must be between 100 and 250.";
    }

    return null;
  }

  static String? validateBMI(String? data) {
    if (data == null || data.isEmpty) {
      return "BMI can't be empty";
    }

    final bmi = double.tryParse(data);
    if (bmi == null) {
      return "BMI must be a number";
    }

    if (bmi < 10 || bmi > 60) {
      return "The field BMI must be between 10 and 60.";
    }

    return null;
  }
}