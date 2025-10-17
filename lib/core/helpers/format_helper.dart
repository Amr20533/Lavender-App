class FormatHelper{

  static String removeExtraDots(String val) {
    num value = num.parse(val);
    if (value % 1 == 0) { 
      return value.toInt().toString();
    }
    return value.toString();
  }

  static String formatTime(String val) {
    List<String> parts = val.split(":");

    if (parts.length == 3) {
      return "${parts[0]}:${parts[1]}";
    }

    return val;
  }



}