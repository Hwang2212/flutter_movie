import 'package:intl/intl.dart';

class ParseData {
  convertLanguage(language) {
    switch (language) {
      case "en":
        return "English";
      case "ja":
        return "Japanese";
      case "te":
        return "Telugu";
      case "fr":
        return "French";
      case "en":
        return "English";
      default:
        return "";
    }
  }

  convertDatetimeFormat(date) {
    DateTime releaseDate = DateFormat("yyyy-MM-dd").parse(date);
    String newDate = DateFormat("yyyy-MM-dd").format(releaseDate);

    return newDate;
  }
}
