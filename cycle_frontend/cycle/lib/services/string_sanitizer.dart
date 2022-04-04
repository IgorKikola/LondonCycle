/// Cuts strings to desired length, adding '...' if the string is too long.
class StringSanitiser {
  static String sanitiseString(String string, int maxLength) =>
      string.length >= maxLength
          ? string.substring(0, maxLength - 1) + '...'
          : string;
}
