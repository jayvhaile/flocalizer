class StringUtils {
  static String capitalize(String string) {
    if (string == null || string.isEmpty) return string;
    return "${string[0].toUpperCase()}${string.substring(1).toLowerCase()}";
  }
}

extension string_utils on String {
  capitalize() => StringUtils.capitalize(this);
}
