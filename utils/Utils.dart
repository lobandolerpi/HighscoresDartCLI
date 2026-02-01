import 'dart:math';

extension EmailValidator on String {
  // This adds the method .isValidEmail() to ANY String in your project
  bool isValidEmail() {
    // A standard Regex for email validation
    final emailRegex = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');

    return emailRegex.hasMatch(this);
  }
}

class Utils {
  static String generateRandomId(int len) {
    const chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random rnd = Random();
    // Un buffer optimitza les trucades a memòria de concatenar strings.
    StringBuffer buffer = StringBuffer(); 
    for (int i = 0; i < len; i++) {
      String c = chars[rnd.nextInt(chars.length)];
      buffer.write(c); 
    }
    return buffer.toString();
  }
}
