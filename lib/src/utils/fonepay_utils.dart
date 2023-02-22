part of fonepay_flutter;

class FonePayUtils {
  /// format date time in :MM/dd/yyyy
  /// eg:06/27/2018

  static String formatDate(DateTime date) {
    String month = date.month.toString().padLeft(2, '0');
    String day = date.day.toString().padLeft(2, '0');
    String year = date.year.toString();
    return '$month/$day/$year';
  }

  /// generate random string based on passed length //default = 6
  static String generateRandomString({int? len}) {
    var r = Random();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len ?? 6, (index) => _chars[r.nextInt(_chars.length)])
        .join()
        .toUpperCase();
  }
}
