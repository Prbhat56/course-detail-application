class InputValidator {
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }
  
  static String? validatePositiveNumber(String? value, String fieldName) {
    final requiredError = validateRequired(value, fieldName);
    if (requiredError != null) return requiredError;
    
    final number = int.tryParse(value!);
    if (number == null || number <= 0) {
      return '$fieldName must be a positive number';
    }
    return null;
  }
}