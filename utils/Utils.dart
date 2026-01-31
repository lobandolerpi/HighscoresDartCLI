extension EmailValidator on String {
  // This adds the method .isValidEmail() to ANY String in your project
  bool isValidEmail() {
    // A standard Regex for email validation
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
    );
    
    return emailRegex.hasMatch(this);
  }
}
