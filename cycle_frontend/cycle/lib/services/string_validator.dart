import 'package:string_validator/string_validator.dart';

import '../utilities/validator_messages.dart';

// Minimum eight characters, at least one letter, one number and
// one special character.
final RegExp passwordRegex =
    RegExp(r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$");

/// An object of this class is responsible for checking whether strings are of a valid format.
class StringValidator {
  /// Checks if the provided string is of a valid name format.
  /// - If it consists of letter only.
  /// - If the first letter is capital.
  /// - If all the other letters are lowercase.
  static ValidatorMessage isFirstName(String toCheck) {
    if (!isAlpha(toCheck)) {
      return ValidatorMessage.nameIsNotOnlyLetters;
    } else if (!isUppercase(toCheck[0])) {
      return ValidatorMessage.firstLetterOfNameMustBeCapital;
    } else if (!(toCheck.substring(1) == toCheck.substring(1).toLowerCase())) {
      return ValidatorMessage.onlyFirstLetterOfNameCanBeCapital;
    } else {
      return ValidatorMessage.defaultMessage;
    }
  }

  /// Checks if the provided string is of a valid name format.
  /// - If it consists of letter only.
  /// - If the first letter is capital.
  /// - If all the other letters are lowercase.
  static ValidatorMessage isLastName(String toCheck) {
    if (!isAlpha(toCheck)) {
      return ValidatorMessage.surnameIsNotOnlyLetters;
    } else if (!isUppercase(toCheck[0])) {
      return ValidatorMessage.firstLetterOfSurnameMustBeCapital;
    } else if (!(toCheck.substring(1) == toCheck.substring(1).toLowerCase())) {
      return ValidatorMessage.onlyFirstLetterOfSurnameCanBeCapital;
    } else {
      return ValidatorMessage.defaultMessage;
    }
  }

  /// Checks if the provided string is of a valid password format according to the specified regex.
  /// - Minimum 8 characters &&
  /// - At least 1 of them is a letter &&
  /// - At least 1 of them is a number &&
  /// - At least 1 of them is a special character from @$!%*#?&
  static ValidatorMessage isValidPassword(String toCheck) {
    return !passwordRegex.hasMatch(toCheck)
        ? ValidatorMessage.passwordIsOfWrongFormat
        : ValidatorMessage.defaultMessage;
  }

  /// Get message to display to the user according to the validator message type.
  static String getText(ValidatorMessage string) {
    switch (string) {
      case ValidatorMessage.firstLetterOfNameMustBeCapital:
        return 'First letter of the name must be capital';
      case ValidatorMessage.firstLetterOfSurnameMustBeCapital:
        return 'First letter of the surname must be capital';
      case ValidatorMessage.onlyFirstLetterOfNameCanBeCapital:
        return 'Only the first letter of the name can be capital';
      case ValidatorMessage.onlyFirstLetterOfSurnameCanBeCapital:
        return 'Only the first letter of the surname can be capital';
      case ValidatorMessage.nameIsNotOnlyLetters:
        return 'Name cannot contain numbers or special symbols';
      case ValidatorMessage.surnameIsNotOnlyLetters:
        return 'Surname cannot contain numbers or special symbols';
      case ValidatorMessage.passwordIsOfWrongFormat:
        return "Password is of a wrong format";
      default:
        return '';
    }
  }
}
