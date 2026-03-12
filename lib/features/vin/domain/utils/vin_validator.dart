/// Validates VIN (Vehicle Identification Number) format and check digit.
///
/// VINs follow ISO 3779 / FMVSS 115:
/// - Exactly 17 alphanumeric characters
/// - Characters I, O, Q are not permitted (too similar to 1, 0, 0)
/// - The 9th character is a check digit (0–9 or X)
class VinValidator {
  VinValidator._();

  static final _vinRegex = RegExp(r'^[A-HJ-NPR-Z0-9]{17}$');

  static const _transliteration = <String, int>{
    'A': 1,
    'B': 2,
    'C': 3,
    'D': 4,
    'E': 5,
    'F': 6,
    'G': 7,
    'H': 8,
    'J': 1,
    'K': 2,
    'L': 3,
    'M': 4,
    'N': 5,
    'P': 7,
    'R': 9,
    'S': 2,
    'T': 3,
    'U': 4,
    'V': 5,
    'W': 6,
    'X': 7,
    'Y': 8,
    'Z': 9,
    '0': 0,
    '1': 1,
    '2': 2,
    '3': 3,
    '4': 4,
    '5': 5,
    '6': 6,
    '7': 7,
    '8': 8,
    '9': 9,
  };

  static const _weights = [
    8,
    7,
    6,
    5,
    4,
    3,
    2,
    10,
    0,
    9,
    8,
    7,
    6,
    5,
    4,
    3,
    2,
  ];

  /// Returns null if [vin] is valid; an error message string if invalid.
  static String? validate(String vin) {
    final upper = vin.toUpperCase().trim();
    if (upper.isEmpty) return 'VIN is required.';
    if (upper.length != 17) {
      return 'VIN must be exactly 17 characters (${upper.length}/17).';
    }
    if (!_vinRegex.hasMatch(upper)) {
      return 'VIN contains invalid characters. I, O, Q are not permitted.';
    }
    if (!_checkDigitValid(upper)) {
      return 'Invalid VIN — check digit verification failed.';
    }
    return null;
  }

  /// Returns true when [vin] passes all validation rules.
  static bool isValid(String vin) => validate(vin) == null;

  static bool _checkDigitValid(String vin) {
    var sum = 0;
    for (var i = 0; i < 17; i++) {
      final value = _transliteration[vin[i]];
      if (value == null) return false;
      sum += value * _weights[i];
    }
    final remainder = sum % 11;
    final expected = remainder == 10 ? 'X' : remainder.toString();
    return vin[8] == expected;
  }
}
