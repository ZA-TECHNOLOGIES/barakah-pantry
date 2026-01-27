/// Validator Helper
/// Utility class for input validation
class ValidatorHelper {
  ValidatorHelper._();

  //═══════════════════════════════════════════════════════════════
  // EMAIL VALIDATION
  //═══════════════════════════════════════════════════════════════

  /// Validate email
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  //═══════════════════════════════════════════════════════════════
  // PASSWORD VALIDATION
  //═══════════════════════════════════════════════════════════════

  /// Validate password
  static String? validatePassword(String? value, {int minLength = 6}) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < minLength) {
      return 'Password must be at least $minLength characters';
    }

    return null;
  }

  /// Validate strong password
  static String? validateStrongPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }

    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }

    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter';
    }

    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }

    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }

    return null;
  }

  /// Validate confirm password
  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }

    if (value != password) {
      return 'Passwords do not match';
    }

    return null;
  }

  //═══════════════════════════════════════════════════════════════
  // NAME VALIDATION
  //═══════════════════════════════════════════════════════════════

  /// Validate name
  static String? validateName(String? value, {String fieldName = 'Name'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }

    if (value.trim().length < 2) {
      return '$fieldName must be at least 2 characters';
    }

    if (value.trim().length > 50) {
      return '$fieldName must not exceed 50 characters';
    }

    // Only allow letters, spaces, hyphens, and apostrophes
    final nameRegex = RegExp(r"^[a-zA-Z\s\-']+$");
    if (!nameRegex.hasMatch(value.trim())) {
      return '$fieldName can only contain letters, spaces, hyphens, and apostrophes';
    }

    return null;
  }

  /// Validate full name (first and last)
  static String? validateFullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Full name is required';
    }

    final parts = value.trim().split(' ');
    if (parts.length < 2) {
      return 'Please enter your first and last name';
    }

    return validateName(value, fieldName: 'Name');
  }

  //═══════════════════════════════════════════════════════════════
  // PHONE VALIDATION
  //═══════════════════════════════════════════════════════════════

  /// Validate phone number
  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }

    // Remove spaces, dashes, and parentheses
    final cleaned = value.replaceAll(RegExp(r'[\s\-\(\)]'), '');

    // Check if it starts with + or is all digits
    final phoneRegex = RegExp(r'^\+?[0-9]{10,15}$');
    if (!phoneRegex.hasMatch(cleaned)) {
      return 'Please enter a valid phone number';
    }

    return null;
  }

  /// Validate optional phone number
  static String? validateOptionalPhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // Optional, so empty is valid
    }
    return validatePhone(value);
  }

  //═══════════════════════════════════════════════════════════════
  // REQUIRED FIELD VALIDATION
  //═══════════════════════════════════════════════════════════════

  /// Validate required field
  static String? validateRequired(String? value,
      {String fieldName = 'This field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  /// Validate required selection
  static String? validateRequiredSelection<T>(T? value,
      {String fieldName = 'Selection'}) {
    if (value == null) {
      return 'Please select a $fieldName';
    }
    return null;
  }

  //═══════════════════════════════════════════════════════════════
  // LENGTH VALIDATION
  //═══════════════════════════════════════════════════════════════

  /// Validate minimum length
  static String? validateMinLength(String? value, int minLength,
      {String fieldName = 'This field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }

    if (value.trim().length < minLength) {
      return '$fieldName must be at least $minLength characters';
    }

    return null;
  }

  /// Validate maximum length
  static String? validateMaxLength(String? value, int maxLength,
      {String fieldName = 'This field'}) {
    if (value != null && value.trim().length > maxLength) {
      return '$fieldName must not exceed $maxLength characters';
    }

    return null;
  }

  /// Validate length range
  static String? validateLengthRange(
      String? value, int minLength, int maxLength,
      {String fieldName = 'This field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }

    if (value.trim().length < minLength) {
      return '$fieldName must be at least $minLength characters';
    }

    if (value.trim().length > maxLength) {
      return '$fieldName must not exceed $maxLength characters';
    }

    return null;
  }

  //═══════════════════════════════════════════════════════════════
  // NUMBER VALIDATION
  //═══════════════════════════════════════════════════════════════

  /// Validate number
  static String? validateNumber(String? value,
      {String fieldName = 'This field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }

    if (double.tryParse(value) == null) {
      return '$fieldName must be a valid number';
    }

    return null;
  }

  /// Validate positive number
  static String? validatePositiveNumber(String? value,
      {String fieldName = 'This field'}) {
    final numberError = validateNumber(value, fieldName: fieldName);
    if (numberError != null) return numberError;

    final number = double.parse(value!);
    if (number <= 0) {
      return '$fieldName must be greater than 0';
    }

    return null;
  }

  /// Validate number range
  static String? validateNumberRange(String? value, double min, double max,
      {String fieldName = 'This field'}) {
    final numberError = validateNumber(value, fieldName: fieldName);
    if (numberError != null) return numberError;

    final number = double.parse(value!);
    if (number < min || number > max) {
      return '$fieldName must be between $min and $max';
    }

    return null;
  }

  /// Validate integer
  static String? validateInteger(String? value,
      {String fieldName = 'This field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }

    if (int.tryParse(value) == null) {
      return '$fieldName must be a whole number';
    }

    return null;
  }

  //═══════════════════════════════════════════════════════════════
  // URL VALIDATION
  //═══════════════════════════════════════════════════════════════

  /// Validate URL
  static String? validateUrl(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'URL is required';
    }

    final urlRegex = RegExp(
      r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
    );

    if (!urlRegex.hasMatch(value.trim())) {
      return 'Please enter a valid URL';
    }

    return null;
  }

  /// Validate optional URL
  static String? validateOptionalUrl(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    return validateUrl(value);
  }

  //═══════════════════════════════════════════════════════════════
  // DATE VALIDATION
  //═══════════════════════════════════════════════════════════════

  /// Validate date is not in past
  static String? validateFutureDate(DateTime? value,
      {String fieldName = 'Date'}) {
    if (value == null) {
      return '$fieldName is required';
    }

    if (value.isBefore(DateTime.now())) {
      return '$fieldName must be in the future';
    }

    return null;
  }

  /// Validate date is not in future
  static String? validatePastDate(DateTime? value,
      {String fieldName = 'Date'}) {
    if (value == null) {
      return '$fieldName is required';
    }

    if (value.isAfter(DateTime.now())) {
      return '$fieldName must be in the past';
    }

    return null;
  }

  /// Validate age (birthdate)
  static String? validateAge(DateTime? value,
      {int minAge = 13, int maxAge = 120}) {
    if (value == null) {
      return 'Birth date is required';
    }

    final now = DateTime.now();
    var age = now.year - value.year;
    if (now.month < value.month ||
        (now.month == value.month && now.day < value.day)) {
      age--;
    }

    if (age < minAge) {
      return 'You must be at least $minAge years old';
    }

    if (age > maxAge) {
      return 'Please enter a valid birth date';
    }

    return null;
  }

  //═══════════════════════════════════════════════════════════════
  // CUSTOM VALIDATION
  //═══════════════════════════════════════════════════════════════

  /// Validate with custom regex
  static String? validateRegex(
      String? value, String pattern, String errorMessage,
      {bool required = true}) {
    if (value == null || value.trim().isEmpty) {
      return required ? 'This field is required' : null;
    }

    if (!RegExp(pattern).hasMatch(value)) {
      return errorMessage;
    }

    return null;
  }

  /// Validate with custom function
  static String? validateCustom(
      String? value, bool Function(String) validator, String errorMessage,
      {bool required = true}) {
    if (value == null || value.trim().isEmpty) {
      return required ? 'This field is required' : null;
    }

    if (!validator(value)) {
      return errorMessage;
    }

    return null;
  }

  //═══════════════════════════════════════════════════════════════
  // INGREDIENT SPECIFIC VALIDATION
  //═══════════════════════════════════════════════════════════════

  /// Validate ingredient name
  static String? validateIngredientName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Ingredient name is required';
    }

    if (value.trim().length < 2) {
      return 'Ingredient name must be at least 2 characters';
    }

    if (value.trim().length > 100) {
      return 'Ingredient name must not exceed 100 characters';
    }

    return null;
  }

  /// Validate quantity
  static String? validateQuantity(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Quantity is required';
    }

    // Allow fractions like "1/2", "1 1/2", decimals, and whole numbers
    final quantityRegex = RegExp(r'^(\d+\s)?\d+\/?\d*\.?\d*$');
    if (!quantityRegex.hasMatch(value.trim())) {
      return 'Please enter a valid quantity (e.g., 1, 1.5, 1/2)';
    }

    return null;
  }

  /// Validate servings
  static String? validateServings(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Number of servings is required';
    }

    final servings = int.tryParse(value);
    if (servings == null) {
      return 'Servings must be a whole number';
    }

    if (servings < 1 || servings > 100) {
      return 'Servings must be between 1 and 100';
    }

    return null;
  }

  /// Validate cooking time
  static String? validateCookingTime(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // Optional
    }

    final time = int.tryParse(value);
    if (time == null) {
      return 'Time must be a whole number';
    }

    if (time < 0 || time > 1440) {
      return 'Time must be between 0 and 1440 minutes';
    }

    return null;
  }
}
