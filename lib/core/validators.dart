class Validator {
  static String? validatePhoneNumber(String? value) {
    final phoneNumberRegExp = RegExp(r"^(?:\+91)?[0-9]{10}$");
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    if (!phoneNumberRegExp.hasMatch(value)) {
      return 'Invalid phone number';
    }
    return null;
  }

  static String? validateAmount(String? value, double expectedAmount) {
    if (value == null || value.isEmpty) {
      return 'Amount is required';
    }
    final enteredAmount = double.tryParse(value);
    if (enteredAmount == null) {
      return 'Enter a valid number';
    }
    if (enteredAmount != expectedAmount) {
      return 'Amount must be ₹$expectedAmount';
    }
    return null;
  }

  static String? validatePaidAmount(String? value, double expectedAmount) {
    if (value == null || value.isEmpty) {
      return 'Amount is required';
    }
    final enteredAmount = double.tryParse(value);
    if (enteredAmount == null) {
      return 'Enter a valid number';
    }
    if (enteredAmount > expectedAmount) {
      return 'Amount cannot exceed ₹$expectedAmount';
    }
    return null;
  }

  static String? validateNotEmpty(String? value, {String fieldName = 'Field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  static String? validateKM(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'KM is required';
    }
    final parsed = double.tryParse(value);
    if (parsed == null) {
      return 'Enter a valid KM';
    }
    return null;
  }

  static String? validateImage(dynamic image) {
    if (image == null) {
      return 'Image is required';
    }
    return null;
  }

  static String? validateReason(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Reason is required';
    }
    if (value.trim().length < 5) {
      return 'Reason should be at least 5 characters';
    }
    return null;
  }

  static String? validatePositiveAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an amount.';
    }
    if (double.tryParse(value) == null) {
      return 'Please enter a valid number.';
    }
    if (double.parse(value) <= 0) {
      return 'Amount must be greater than zero.';
    }
    return null;
  }

  static bool isValidVehicleNumber(String vehicleNumber) {
    final cleaned = vehicleNumber.replaceAll(' ', ''); // Remove spaces
    final pattern = r'^[a-zA-Z0-9]{4,}$'; // Min 4 alphanumeric characters
    final regExp = RegExp(pattern);
    return regExp.hasMatch(cleaned);
  }
}
