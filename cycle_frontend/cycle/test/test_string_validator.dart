import 'package:cycle/components/slide_up_widget.dart';
import 'package:cycle/services/string_validator.dart';
import 'package:cycle/utilities/validator_messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  /// FIRST NAME VALIDATION TESTS

  test(
      'String validator does not accept names that start with lowercase letters.',
      () {
    const input = 'jack';
    final answer = StringValidator.isFirstName(input);
    expect(answer, ValidatorMessage.firstLetterOfNameMustBeCapital);
  });

  test(
      'String validator does not accept names that contain other symbols than letters.',
      () {
    const input = 'J3ck';
    final answer = StringValidator.isFirstName(input);
    expect(answer, ValidatorMessage.nameIsNotOnlyLetters);
  });

  test(
      'String validator does not accept names who have uppercase letters not in the head.',
      () {
    const input = 'JaCk';
    final answer = StringValidator.isFirstName(input);
    expect(answer, ValidatorMessage.onlyFirstLetterOfNameCanBeCapital);
  });

  test('String validator accepts first names of a valid name format.', () {
    const input = 'Jack';
    final answer = StringValidator.isFirstName(input);
    expect(answer, ValidatorMessage.defaultMessage);
  });

  /// LAST NAME VALIDATION TESTS

  test(
      'String validator does not accept surnames that start with lowercase letters.',
      () {
    const input = 'johnson';
    final answer = StringValidator.isLastName(input);
    expect(answer, ValidatorMessage.firstLetterOfSurnameMustBeCapital);
  });

  test(
      'String validator does not accept last names that contain other symbols than letters.',
      () {
    const input = 'johns4o#n';
    final answer = StringValidator.isLastName(input);
    expect(answer, ValidatorMessage.surnameIsNotOnlyLetters);
  });

  test(
      'String validator does not accept surnames who have uppercase letters not in the head.',
      () {
    const input = 'JohnsON';
    final answer = StringValidator.isLastName(input);
    expect(answer, ValidatorMessage.onlyFirstLetterOfSurnameCanBeCapital);
  });

  test('String validator accepts last names of a valid name format.', () {
    const input = 'Johnson';
    final answer = StringValidator.isLastName(input);
    expect(answer, ValidatorMessage.defaultMessage);
  });

  /// PASSWORD VALIDATION TESTS

  test('String validator does not accept passwords of less than 8 characters.',
      () {
    const input = 'Pass23@';
    final answer = StringValidator.isValidPassword(input);
    expect(answer, ValidatorMessage.passwordIsOfWrongFormat);
  });

  test(
      'String validator does not accept passwords that do not contain any numbers.',
      () {
    const input = 'Password@';
    final answer = StringValidator.isValidPassword(input);
    expect(answer, ValidatorMessage.passwordIsOfWrongFormat);
  });

  test(
      'String validator does not accept passwords that do not contain any letters.',
      () {
    const input = '12345678@';
    final answer = StringValidator.isValidPassword(input);
    expect(answer, ValidatorMessage.passwordIsOfWrongFormat);
  });

  test(
      'String validator does not accept passwords that do not contain any special characters from the set ['
      '@\$!%*#?&].', () {
    const input = 'Password123';
    final answer = StringValidator.isValidPassword(input);
    expect(answer, ValidatorMessage.passwordIsOfWrongFormat);
  });

  test(
      'String validator accepts passwords that comply with the configured regex.',
      () {
    const input = 'Password123@';
    final answer = StringValidator.isValidPassword(input);
    expect(answer, ValidatorMessage.defaultMessage);
  });
}
