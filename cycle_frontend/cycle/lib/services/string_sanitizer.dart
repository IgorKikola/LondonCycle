class StringSanitiser {
  static String sanitiseString(String string, int maxLength) =>
      string.length >= maxLength
          ? string.substring(0, maxLength - 1) + '...'
          : string;
}
