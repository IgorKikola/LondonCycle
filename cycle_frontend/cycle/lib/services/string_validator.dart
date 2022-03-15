import 'package:string_validator/string_validator.dart';
import 'validator_messages.dart';

// Minimum eight characters, at least one letter, one number and
// one special character.
final RegExp passwordRegex =
    RegExp(r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$");

class StringValidator {
  StringValidator();

  ValidatorMessage isFirstName(String toCheck) {
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

  ValidatorMessage isLastName(String toCheck) {
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

  ValidatorMessage isValidPassword(String toCheck) {
    return !passwordRegex.hasMatch(toCheck)
        ? ValidatorMessage.passwordIsOfWrongFormat
        : ValidatorMessage.defaultMessage;
  }

  String getText(ValidatorMessage string) {
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
