import 'package:equatable/equatable.dart';

/// Represents a user's payment credit card.
class PaymentCard extends Equatable {
  const PaymentCard({
    required this.id,
    required this.cardHolder,
    required this.cardNumber,
    required this.expiry,
    required this.cvc,
    required this.brand,
    this.isDefault = false,
  });

  final String id;
  final String cardHolder;
  final String cardNumber; // Full number or last 4 digits depending on usage.
  final String expiry; // Format: MM/YY
  final String cvc;
  final String brand; // e.g., 'Visa', 'Mastercard'
  final bool isDefault;

  /// Returns the masked version of the card number (e.g., "•••• •••• •••• 4291").
  String get maskedNumber {
    final clean = cardNumber.replaceAll(RegExp(r'\s+\b|\b\s+'), '');
    if (clean.length >= 4) {
      final last4 = clean.substring(clean.length - 4);
      return '••••  ••••  ••••  $last4';
    }
    return cardNumber;
  }

  /// Returns the last 4 digits of the card.
  String get last4 {
    final clean = cardNumber.replaceAll(RegExp(r'\s+'), '');
    if (clean.length >= 4) {
      return clean.substring(clean.length - 4);
    }
    return clean;
  }

  PaymentCard copyWith({
    String? id,
    String? cardHolder,
    String? cardNumber,
    String? expiry,
    String? cvc,
    String? brand,
    bool? isDefault,
  }) {
    return PaymentCard(
      id: id ?? this.id,
      cardHolder: cardHolder ?? this.cardHolder,
      cardNumber: cardNumber ?? this.cardNumber,
      expiry: expiry ?? this.expiry,
      cvc: cvc ?? this.cvc,
      brand: brand ?? this.brand,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  @override
  List<Object?> get props => [id, cardHolder, cardNumber, expiry, cvc, brand, isDefault];
}
